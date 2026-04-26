class Nutrition {
  /// If true, values are per-serving; else they are totals for the whole recipe.
  final bool perServing;
  /// Optional: indicates whether values are per 100g or per serving.
  /// When missing, [perServing] is used as fallback.
  final String basis; // per_100g | per_serving | unknown
  final int calories;
  final double protein;
  final double carbs;
  final double fat;

  const Nutrition({
    this.perServing = true,
    this.basis = 'unknown',
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory Nutrition.fromJson(Map<String, Object?> json) {
    final basisRaw = (json['basis'] as String?)?.trim();
    final basis = (basisRaw == 'per_100g' || basisRaw == 'per_serving') ? basisRaw! : 'unknown';
    final perServing = basis == 'per_serving'
        ? true
        : basis == 'per_100g'
            ? false
            : (json['perServing'] as bool?) ?? (json['per_serving'] as bool?) ?? true;
    final protein = (json['protein'] as num?)?.toDouble() ?? 0;
    final carbs = (json['carbs'] as num?)?.toDouble() ?? 0;
    final fat = (json['fat'] as num?)?.toDouble() ?? 0;
    final explicit = (json['calories'] as num?)?.toInt();
    final calories = explicit ??
        (protein * 4 + carbs * 4 + fat * 9).round();
    return Nutrition(
      perServing: perServing,
      basis: basis,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'perServing': perServing,
      if (basis != 'unknown') 'basis': basis,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}

class RecipeIngredient {
  final String name;
  /// Numeric part of the ingredient amount (string to preserve user formatting).
  final String amount;
  /// Unit code like g/ml/adet/yk/tk etc.
  final String unit;
  final bool isAvailable;

  const RecipeIngredient({
    required this.name,
    required this.amount,
    this.unit = '',
    this.isAvailable = true,
  });

  static RecipeIngredient _fromLegacyAmountString({
    required String name,
    required String legacyAmount,
    bool isAvailable = true,
  }) {
    final raw = legacyAmount.trim();
    if (raw.isEmpty) {
      return RecipeIngredient(name: name, amount: '', unit: '', isAvailable: isAvailable);
    }
    // Accept "200 g", "1 adet", "2 yk" etc.
    final parts = raw.split(RegExp(r'\s+')).where((p) => p.trim().isNotEmpty).toList(growable: false);
    if (parts.length == 1) {
      return RecipeIngredient(name: name, amount: parts.first, unit: '', isAvailable: isAvailable);
    }
    final first = parts.first;
    final rest = parts.sublist(1).join(' ');
    return RecipeIngredient(name: name, amount: first, unit: rest, isAvailable: isAvailable);
  }

  factory RecipeIngredient.fromJson(Map<String, Object?> json) {
    final name = (json['name'] as String?) ?? '';
    final isAvailable = (json['isAvailable'] as bool?) ?? (json['is_available'] as bool?) ?? true;

    // New schema: separate amount + unit
    final amount = (json['amount'] as String?)?.trim();
    final unit = (json['unit'] as String?)?.trim();
    if (amount != null) {
      return RecipeIngredient(
        name: name,
        amount: amount,
        unit: unit ?? '',
        isAvailable: isAvailable,
      );
    }

    // Legacy: amount string like "200 g"
    final legacyAmount = (json['amountLegacy'] as String?) ?? (json['amount_legacy'] as String?) ?? '';
    if (legacyAmount.trim().isNotEmpty) {
      return _fromLegacyAmountString(name: name, legacyAmount: legacyAmount, isAvailable: isAvailable);
    }

    return RecipeIngredient(
      name: name,
      amount: '',
      unit: '',
      isAvailable: isAvailable,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
      'isAvailable': isAvailable,
    };
  }
}

/// [categoryKey]: high_protein | vegan | low_carb | quick | dinner | lunch
/// [dietaryTags]: canonical keys matching [DietKeys].
class Recipe {
  final String id;
  /// Display name (Turkish).
  final String name;
  final String emoji;
  /// Optional remote image URL from DB (e.g. dataset image).
  final String? imageUrl;
  /// breakfast | lunch | dinner | snack
  final String category;
  final String cuisineType;
  final int servings;
  final int prepTimeMinutes;
  /// Optional legacy field; kept for backward compatibility with older seed data/UI.
  final String categoryKey;
  final List<RecipeIngredient> ingredients;
  final Nutrition nutrition;
  final List<String> collections;
  final List<String> dietaryTags;
  final List<String> allergens;
  final String source;
  final bool isApproved;
  final String status; // active | pending | rejected
  final bool isPremium;
  final String difficulty;
  final List<String> steps;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Recipe({
    required this.id,
    required this.name,
    required this.emoji,
    this.imageUrl,
    this.category = 'lunch',
    this.cuisineType = 'turkish',
    this.servings = 1,
    required this.prepTimeMinutes,
    this.categoryKey = 'all',
    required this.ingredients,
    required this.nutrition,
    this.collections = const [],
    this.dietaryTags = const [],
    this.allergens = const [],
    this.source = 'custom',
    this.isApproved = true,
    this.status = 'active',
    this.isPremium = false,
    this.difficulty = 'Kolay',
    this.steps = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, Object?> json) {
    final ingredientsJson = json['ingredients'];
    final stepsJson = json['steps'];
    final collectionsJson = json['collections'];
    final dietaryTagsJson = json['dietaryTags'] ?? json['dietary_tags'];
    final macrosJson = json['macros'] ?? json['nutrition'];
    final allergensJson = json['allergens'];
    final imageRaw = json['imageUrl'] ??
        json['image_url'] ??
        json['image'] ??
        json['photo_url'] ??
        json['photoUrl'];

    String? cleanImage(Object? v) {
      final s = v?.toString().trim();
      if (s == null || s.isEmpty) return null;
      if (!s.startsWith('http://') && !s.startsWith('https://')) return null;
      return s;
    }

    String deriveEmoji({
      required String name,
      required String category,
      Object? mainCategory,
      Object? categoryBread,
      Object? keywords,
    }) {
      final hay = [
        name,
        category,
        mainCategory?.toString() ?? '',
        categoryBread?.toString() ?? '',
        keywords?.toString() ?? '',
      ].join(' ').toLowerCase();

      bool hasAny(List<String> words) => words.any(hay.contains);

      // Broad matches first
      if (hasAny(['çorba', 'corba', 'soup'])) return '🥣';
      if (hasAny(['salata', 'salad'])) return '🥗';
      if (hasAny(['köfte', 'kofte', 'burger'])) return '🍖';
      if (hasAny(['tavuk', 'chicken'])) return '🍗';
      if (hasAny(['balık', 'balik', 'fish', 'somon', 'ton', 'tuna'])) return '🐟';
      if (hasAny(['et', 'beef', 'kuzu', 'dana', 'kırmızı et', 'kirmizi et', 'steak'])) return '🥩';
      if (hasAny(['pilav', 'pirinç', 'pirinc', 'rice'])) return '🍚';
      if (hasAny(['makarna', 'pasta', 'spaghetti', 'penne', 'noodle', 'noodles'])) return '🍝';
      if (hasAny(['pizza'])) return '🍕';
      if (hasAny(['sandviç', 'sandvic', 'sandwich', 'tost'])) return '🥪';
      if (hasAny(['yumurta', 'omlet', 'egg', 'menemen'])) return '🍳';
      if (hasAny(['börek', 'borek', 'poğaça', 'pogaca', 'pide', 'lahmacun'])) return '🥟';
      if (hasAny(['kebap', 'döner', 'doner', 'dürüm', 'durum'])) return '🥙';
      if (hasAny(['fasulye', 'nohut', 'mercimek', 'lentil', 'bean', 'chickpea'])) return '🫘';
      if (hasAny(['sebze', 'vegan', 'vegetarian', 'tofu'])) return '🥦';
      if (hasAny(['tatlı', 'dessert', 'pasta', 'kek', 'kurabiye', 'cookie', 'brownie'])) return '🍰';
      if (hasAny(['meyve', 'fruit', 'smoothie'])) return '🍓';

      // Meal-type hint
      final mt = category.trim().toLowerCase();
      if (mt == 'breakfast') return '🍳';
      if (mt == 'snack') return '🥪';
      if (mt == 'dinner') return '🍲';
      if (mt == 'lunch') return '🍽️';

      return '🍽️';
    }

    final List<RecipeIngredient> ingredients;
    if (ingredientsJson is List) {
      if (ingredientsJson.isNotEmpty && ingredientsJson.first is String) {
        ingredients = ingredientsJson
            .whereType<String>()
            .map(
              (s) => RecipeIngredient(
                name: s,
                amount: '',
                unit: '',
                isAvailable: true,
              ),
            )
            .toList(growable: false);
      } else {
        ingredients = ingredientsJson
            .whereType<Map>()
            .map((m) => Map<String, Object?>.from(m))
            .map(RecipeIngredient.fromJson)
            .toList(growable: false);
      }
    } else {
      ingredients = const <RecipeIngredient>[];
    }

    final steps = (stepsJson is List)
        ? stepsJson.whereType<String>().toList(growable: false)
        : const <String>[];

    final collections = (collectionsJson is List)
        ? collectionsJson.whereType<String>().toList(growable: false)
        : const <String>[];

    final dietaryTags = (dietaryTagsJson is List)
        ? dietaryTagsJson.whereType<String>().toList(growable: false)
        : const <String>[];

    final allergens = (allergensJson is List)
        ? allergensJson.whereType<String>().toList(growable: false)
        : const <String>[];

    final nutrition = (macrosJson is Map)
        ? Nutrition.fromJson(Map<String, Object?>.from(macrosJson))
        : const Nutrition(calories: 0, protein: 0, carbs: 0, fat: 0);

    DateTime? tryParseDate(Object? v) {
      final s = v?.toString().trim();
      if (s == null || s.isEmpty) return null;
      return DateTime.tryParse(s);
    }

    return Recipe(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      emoji: (() {
        final raw = (json['emoji'] as String?)?.trim();
        // If there's an image, keep emoji minimal (but still valid).
        if (raw != null && raw.isNotEmpty && raw != '🍽️') return raw;
        // If photo missing or emoji missing/default, derive a category-based one.
        return deriveEmoji(
          name: (json['name'] as String?) ?? '',
          category: (json['category'] as String?) ?? (json['mealType'] as String?) ?? 'lunch',
          mainCategory: json['mainCategory'],
          categoryBread: json['categoryBread'],
          keywords: json['keywords'],
        );
      })(),
      imageUrl: cleanImage(imageRaw),
      category: (json['category'] as String?) ?? (json['mealType'] as String?) ?? 'lunch',
      cuisineType: (json['cuisineType'] as String?) ?? (json['cuisine_type'] as String?) ?? 'turkish',
      servings: (json['servings'] as num?)?.toInt() ?? 1,
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ??
          (json['time_minutes'] as num?)?.toInt() ??
          0,
      categoryKey: (json['categoryKey'] as String?) ??
          (json['category_key'] as String?) ??
          'all',
      ingredients: ingredients,
      nutrition: nutrition,
      collections: collections,
      dietaryTags: dietaryTags,
      allergens: allergens,
      source: (json['source'] as String?) ?? 'custom',
      isApproved: (json['isApproved'] as bool?) ?? (json['is_approved'] as bool?) ?? true,
      status: (json['status'] as String?) ?? 'active',
      isPremium: (json['isPremium'] as bool?) ?? (json['is_premium'] as bool?) ?? false,
      difficulty: (json['difficulty'] as String?) ?? 'Kolay',
      steps: steps,
      createdAt: tryParseDate(json['createdAt'] ?? json['created_at']),
      updatedAt: tryParseDate(json['updatedAt'] ?? json['updated_at']),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      if (imageUrl != null && imageUrl!.trim().isNotEmpty) 'imageUrl': imageUrl,
      'category': category,
      'cuisineType': cuisineType,
      'servings': servings,
      'prepTimeMinutes': prepTimeMinutes,
      'categoryKey': categoryKey,
      'ingredients': ingredients.map((i) => i.toJson()).toList(growable: false),
      'macros': nutrition.toJson(),
      'collections': collections,
      'dietaryTags': dietaryTags,
      'allergens': allergens,
      'source': source,
      'isApproved': isApproved,
      'status': status,
      'isPremium': isPremium,
      'difficulty': difficulty,
      'steps': steps,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  int get stepCount => steps.length;

  int get missingCount => ingredients.where((i) => !i.isAvailable).length;
  int get availableCount => ingredients.where((i) => i.isAvailable).length;
}
