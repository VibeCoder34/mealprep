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

  int get stepCount => steps.length;

  int get missingCount => ingredients.where((i) => !i.isAvailable).length;
  int get availableCount => ingredients.where((i) => i.isAvailable).length;
}
