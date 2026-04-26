import '../models/inventory_item.dart';
import '../models/recipe.dart';
import '../models/recipe_filter.dart';
import 'ingredient_normalizer.dart';

class RecipeMatchResult {
  final Recipe recipe;
  final int matchPercent; // 0..100
  final int matchedCount;
  final int totalCount;
  final List<RecipeIngredient> missingIngredients;
  final bool hasFavoriteIngredient;

  const RecipeMatchResult({
    required this.recipe,
    required this.matchPercent,
    required this.matchedCount,
    required this.totalCount,
    required this.missingIngredients,
    required this.hasFavoriteIngredient,
  });

  int get missingCount => missingIngredients.length;
}

enum RecipeSortOption { bestMatch, newest, popular, rating }

class RecipeDiscoveryService {
  RecipeDiscoveryService({IngredientNormalizer? normalizer})
      : _normalizer = normalizer ?? const IngredientNormalizer();

  final IngredientNormalizer _normalizer;

  bool _matchesInventory(String ingredient, Set<String> inventorySet) {
    final ing = _normalizer.normalize(ingredient);
    if (ing.isEmpty) return false;
    if (inventorySet.contains(ing)) return true;

    // Substring heuristic: "büyük boy soğan" vs "soğan"
    if (ing.length >= 4) {
      for (final inv in inventorySet) {
        if (inv.length < 4) continue;
        if (ing.contains(inv) || inv.contains(ing)) return true;
      }
    }
    return false;
  }

  List<RecipeMatchResult> discover({
    required List<Recipe> recipes,
    required List<InventoryItem> inventory,
    required RecipeFilter filter,
    required RecipeSortOption sort,
    bool hideLowMatchByDefault = true,
  }) {
    final inventorySet = inventory
        .map((i) => _normalizer.normalize(i.name))
        .where((s) => s.isNotEmpty)
        .toSet();

    bool passesFilters(Recipe r) {
      if (r.status != 'active') return false;
      if (!r.isApproved) return false;

      // Meal type
      final mt = filter.mealType;
      if (mt != null && mt.trim().isNotEmpty) {
        if (r.category.trim().toLowerCase() != mt.trim().toLowerCase()) return false;
      }

      // Dietary tags (AND)
      if (filter.dietaryTags.isNotEmpty) {
        final tags = r.dietaryTags.toSet();
        if (!filter.dietaryTags.every(tags.contains)) return false;
      }

      // Allergens: treated as hard excludes via excludeIngredients (UI can feed allergy list here)
      if (filter.excludeIngredients.isNotEmpty) {
        final normalizedExcludes = filter.excludeIngredients.map(_normalizer.normalize).toSet();
        final normalizedRecipeIngredients = r.ingredients
            .map((i) => _normalizer.normalize(i.name))
            .where((s) => s.isNotEmpty)
            .toSet();
        if (normalizedRecipeIngredients.any(normalizedExcludes.contains)) return false;
      }

      // Difficulty
      if (filter.difficulties.isNotEmpty) {
        if (!filter.difficulties.contains(r.difficulty)) return false;
      }

      // Prep time
      if (filter.maxPrepTimeMinutes != null) {
        if (r.prepTimeMinutes > filter.maxPrepTimeMinutes!) return false;
      }

      // Calories range (use nutrition.calories as-is; assumed per serving by default)
      if (filter.minCalories != null) {
        if (r.nutrition.calories < filter.minCalories!) return false;
      }
      if (filter.maxCalories != null) {
        if (r.nutrition.calories > filter.maxCalories!) return false;
      }

      return true;
    }

    RecipeMatchResult computeMatch(Recipe r) {
      final normalizedIngredients = r.ingredients
          .map((i) => _normalizer.normalize(i.name))
          .where((s) => s.isNotEmpty)
          .toList(growable: false);

      final total = normalizedIngredients.length;
      var matched = 0;
      final missing = <RecipeIngredient>[];

      for (var idx = 0; idx < r.ingredients.length; idx++) {
        final ing = r.ingredients[idx];
        final key = _normalizer.normalize(ing.name);
        if (key.isEmpty) continue;
        if (_matchesInventory(ing.name, inventorySet)) {
          matched += 1;
        } else {
          missing.add(ing);
        }
      }

      final percent = total == 0 ? 0 : ((matched / total) * 100).round();

      final fav = filter.favoriteIngredients.isNotEmpty
          ? r.ingredients
              .map((i) => _normalizer.normalize(i.name))
              .any(filter.favoriteIngredients.map(_normalizer.normalize).toSet().contains)
          : false;

      return RecipeMatchResult(
        recipe: r,
        matchPercent: percent,
        matchedCount: matched,
        totalCount: total,
        missingIngredients: missing,
        hasFavoriteIngredient: fav,
      );
    }

    final filtered = recipes.where(passesFilters).map(computeMatch).toList(growable: false);

    final visible = hideLowMatchByDefault ? filtered.where((r) => r.matchPercent >= 30).toList(growable: false) : filtered;

    int diffRank(String d) {
      switch (d.trim()) {
        case 'Çok Kolay':
          return 0;
        case 'Kolay':
          return 1;
        case 'Orta':
          return 2;
        case 'Zor':
          return 3;
      }
      return 4;
    }

    visible.sort((a, b) {
      if (sort != RecipeSortOption.bestMatch) {
        // Placeholder: we don't have popularity/new timestamps/ratings in the client yet.
        // Fall back to bestMatch ordering.
      }

      // 1) match %
      final mp = b.matchPercent.compareTo(a.matchPercent);
      if (mp != 0) return mp;

      // 2) favorite boost
      final fav = (b.hasFavoriteIngredient ? 1 : 0).compareTo(a.hasFavoriteIngredient ? 1 : 0);
      if (fav != 0) return fav;

      // 3) difficulty (easy first)
      final dr = diffRank(a.recipe.difficulty).compareTo(diffRank(b.recipe.difficulty));
      if (dr != 0) return dr;

      // 4) prep time (fast first)
      final tr = a.recipe.prepTimeMinutes.compareTo(b.recipe.prepTimeMinutes);
      if (tr != 0) return tr;

      // 5) name
      return a.recipe.name.toLowerCase().compareTo(b.recipe.name.toLowerCase());
    });

    return visible;
  }
}

