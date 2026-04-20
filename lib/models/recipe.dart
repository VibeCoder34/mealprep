class Nutrition {
  final int calories;
  final int protein;
  final int carbs;
  final int fat;

  const Nutrition({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory Nutrition.fromJson(Map<String, Object?> json) {
    final protein = (json['protein'] as num?)?.toInt() ?? 0;
    final carbs = (json['carbs'] as num?)?.toInt() ?? 0;
    final fat = (json['fat'] as num?)?.toInt() ?? 0;
    final explicit = (json['calories'] as num?)?.toInt();
    final calories = explicit ??
        (protein * 4 + carbs * 4 + fat * 9).round();
    return Nutrition(
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}

class RecipeIngredient {
  final String name;
  final String amount;
  final bool isAvailable;

  const RecipeIngredient({
    required this.name,
    required this.amount,
    this.isAvailable = true,
  });

  factory RecipeIngredient.fromJson(Map<String, Object?> json) {
    return RecipeIngredient(
      name: (json['name'] as String?) ?? '',
      amount: (json['amount'] as String?) ?? '',
      isAvailable: (json['isAvailable'] as bool?) ?? true,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'amount': amount,
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
  final int prepTimeMinutes;
  final String categoryKey;
  final List<RecipeIngredient> ingredients;
  final Nutrition nutrition;
  final List<String> collections;
  final List<String> dietaryTags;
  final bool isPremium;
  final String difficulty;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.emoji,
    required this.prepTimeMinutes,
    required this.categoryKey,
    required this.ingredients,
    required this.nutrition,
    this.collections = const [],
    this.dietaryTags = const [],
    this.isPremium = false,
    this.difficulty = 'Kolay',
    this.steps = const [],
  });

  factory Recipe.fromJson(Map<String, Object?> json) {
    final ingredientsJson = json['ingredients'];
    final stepsJson = json['steps'];
    final collectionsJson = json['collections'];
    final dietaryTagsJson = json['dietaryTags'] ?? json['dietary_tags'];
    final macrosJson = json['macros'] ?? json['nutrition'];

    final List<RecipeIngredient> ingredients;
    if (ingredientsJson is List) {
      if (ingredientsJson.isNotEmpty && ingredientsJson.first is String) {
        ingredients = ingredientsJson
            .whereType<String>()
            .map(
              (s) => RecipeIngredient(
                name: s,
                amount: '',
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

    final nutrition = (macrosJson is Map)
        ? Nutrition.fromJson(Map<String, Object?>.from(macrosJson))
        : const Nutrition(calories: 0, protein: 0, carbs: 0, fat: 0);

    return Recipe(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      emoji: (json['emoji'] as String?) ?? '🍽️',
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
      isPremium: (json['isPremium'] as bool?) ?? (json['is_premium'] as bool?) ?? false,
      difficulty: (json['difficulty'] as String?) ?? 'Kolay',
      steps: steps,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'prepTimeMinutes': prepTimeMinutes,
      'categoryKey': categoryKey,
      'ingredients': ingredients.map((i) => i.toJson()).toList(growable: false),
      'macros': nutrition.toJson(),
      'collections': collections,
      'dietaryTags': dietaryTags,
      'isPremium': isPremium,
      'difficulty': difficulty,
      'steps': steps,
    };
  }

  int get stepCount => steps.length;

  int get missingCount => ingredients.where((i) => !i.isAvailable).length;
  int get availableCount => ingredients.where((i) => i.isAvailable).length;
}
