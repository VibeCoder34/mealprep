class RecipeFilter {
  /// breakfast | lunch | dinner | snack | null (no filter)
  final String? mealType;

  /// Dietary tag keys; all must match (AND).
  final Set<String> dietaryTags;

  /// Prep time upper bound in minutes (null = no filter)
  final int? maxPrepTimeMinutes;

  /// Calories range (null = no filter)
  final int? minCalories;
  final int? maxCalories;

  /// Difficulty labels in Turkish: Çok Kolay/Kolay/Orta/Zor
  final Set<String> difficulties;

  /// Exclude ingredients: if recipe contains any of these => filtered out.
  final Set<String> excludeIngredients;

  /// Favorite ingredients: boosts ranking if present.
  final Set<String> favoriteIngredients;

  const RecipeFilter({
    this.mealType,
    this.dietaryTags = const {},
    this.maxPrepTimeMinutes,
    this.minCalories,
    this.maxCalories,
    this.difficulties = const {},
    this.excludeIngredients = const {},
    this.favoriteIngredients = const {},
  });

  RecipeFilter copyWith({
    String? mealType,
    bool clearMealType = false,
    Set<String>? dietaryTags,
    int? maxPrepTimeMinutes,
    bool clearMaxPrepTimeMinutes = false,
    int? minCalories,
    bool clearMinCalories = false,
    int? maxCalories,
    bool clearMaxCalories = false,
    Set<String>? difficulties,
    Set<String>? excludeIngredients,
    Set<String>? favoriteIngredients,
  }) {
    return RecipeFilter(
      mealType: clearMealType ? null : (mealType ?? this.mealType),
      dietaryTags: dietaryTags ?? this.dietaryTags,
      maxPrepTimeMinutes: clearMaxPrepTimeMinutes ? null : (maxPrepTimeMinutes ?? this.maxPrepTimeMinutes),
      minCalories: clearMinCalories ? null : (minCalories ?? this.minCalories),
      maxCalories: clearMaxCalories ? null : (maxCalories ?? this.maxCalories),
      difficulties: difficulties ?? this.difficulties,
      excludeIngredients: excludeIngredients ?? this.excludeIngredients,
      favoriteIngredients: favoriteIngredients ?? this.favoriteIngredients,
    );
  }

  static const empty = RecipeFilter();
}

