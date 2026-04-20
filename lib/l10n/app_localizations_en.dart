// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Meal Prep';

  @override
  String get navPantry => 'Pantry';

  @override
  String get navRecipes => 'Recipes';

  @override
  String get navShopping => 'Shopping';

  @override
  String get navSettings => 'Settings';

  @override
  String get onboarding1Title => 'Organize Your Kitchen';

  @override
  String get onboarding1Body =>
      'Track your pantry by snapping a photo\nor adding items manually.';

  @override
  String get onboarding2Title => 'Smart Recipes';

  @override
  String get onboarding2Body =>
      'Get personalized recipe ideas\nbased on what you already have.';

  @override
  String get onboarding3Title => 'Shopping List';

  @override
  String get onboarding3Body =>
      'Missing ingredients are listed\nautomatically. Easy to share too.';

  @override
  String get skip => 'Skip';

  @override
  String get continueButton => 'Continue';

  @override
  String get letsGo => 'Let\'s Go';

  @override
  String get myKitchen => 'My Kitchen';

  @override
  String get yourPantry => 'Your Pantry';

  @override
  String totalItemsCount(int count) {
    return 'Total: $count items';
  }

  @override
  String get addItem => 'Add Item';

  @override
  String get addToPantry => 'Add to Pantry';

  @override
  String get takePhotoOrManual => 'Take a photo or add manually';

  @override
  String get getStarted => 'Get Started';

  @override
  String get delete => 'Delete';

  @override
  String get lowInventoryHint => 'Add more items to discover more recipes';

  @override
  String get addMoreShort => 'Add →';

  @override
  String get pantryEmpty => 'Pantry is Empty';

  @override
  String get pantryEmptySubtitle =>
      'Start adding your kitchen items to discover personalized recipes.';

  @override
  String get addFirstItem => 'Add Your First Item';

  @override
  String get recipeSuggestions => 'Recipe Suggestions';

  @override
  String get noPantryItems => 'No items in your pantry';

  @override
  String get noPantryItemsSubtitle =>
      'Add kitchen items to your pantry first\nto get personalized recipe suggestions.';

  @override
  String get addItemsButton => 'Add Items';

  @override
  String get discoverRecipes => 'Discover Recipes';

  @override
  String personalizedRecipesBody(int count) {
    return 'We\'ll create personalized recipes\nbased on your $count pantry items.';
  }

  @override
  String get generateRecipes => 'Generate Recipes';

  @override
  String get fromPantry => 'From Pantry';

  @override
  String get quickRecipes => 'Quick Recipes';

  @override
  String withPantryItemsCount(int count) {
    return 'With $count items in your pantry';
  }

  @override
  String recipesFoundCount(int count) {
    return '$count recipes found!';
  }

  @override
  String get refresh => 'Refresh';

  @override
  String get noRecipesInCategory => 'No recipes found in this category';

  @override
  String get recipesLoading => 'Loading recipes…';

  @override
  String get recipesLoadFailed => 'Could not load recipes. Please try again.';

  @override
  String get recipesEmpty => 'No recipes yet';

  @override
  String get recipesNoDietMatch =>
      'No recipes match your nutrition preferences';

  @override
  String get retryLoad => 'Try again';

  @override
  String get premiumRecipeCreateHint => 'Create your own recipe with Premium';

  @override
  String get categoryBalanced => 'Balanced';

  @override
  String prepTimeMin(int n) {
    return '$n min';
  }

  @override
  String get recipeCardAllAvailable => 'All ingredients available ✓';

  @override
  String recipeCardPartial(int available, int total, int missing) {
    return '$available/$total available  ·  $missing missing';
  }

  @override
  String get savedRecipesTitle => 'Saved Recipes';

  @override
  String get premiumUnlimitedSavedRecipes =>
      'Unlimited saved recipes for Premium';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get collectionsAll => 'All';

  @override
  String get rateRecipeTitle => 'Rate';

  @override
  String get addCommentLabel => 'Add Comment';

  @override
  String get ratingSave => 'Save';

  @override
  String get ratingDelete => 'Delete';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryBreakfast => 'Breakfast';

  @override
  String get categoryDinner => 'Dinner';

  @override
  String get categorySnack => 'Snack';

  @override
  String get categoryHighProtein => 'High protein';

  @override
  String get categoryVeganFilter => 'Vegan';

  @override
  String get categoryLowCarb => 'Low carb';

  @override
  String get categoryQuick => 'Quick';

  @override
  String get categoryLunch => 'Lunch';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyVeryEasy => 'Very easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get dietHighProtein => 'High protein';

  @override
  String get dietLowCarb => 'Low carb';

  @override
  String get premiumFeatureTitle => 'This feature is part of Premium';

  @override
  String get premiumFeatureDefaultBody =>
      'Unlock AI tools, weekly planning, and unlimited filters and saves.';

  @override
  String get upgradeToPremiumCta => 'Upgrade to Premium';

  @override
  String get premiumUnlimitedFiltersTitle => 'Unlimited filters on Premium';

  @override
  String get premiumUnlimitedFiltersBody =>
      'Pick as many dietary filters as you need with Premium.';

  @override
  String get premiumUnlimitedSavedTitle => 'Unlimited saves on Premium';

  @override
  String get premiumUnlimitedSavedBody =>
      'Save as many recipes as you want with Premium.';

  @override
  String get featAiRecipeCreate => 'Create recipe (AI)';

  @override
  String get featMacroOptimize => 'Optimize macros';

  @override
  String get featWeeklyMealPlan => 'Weekly meal plan';

  @override
  String get featNutritionAnalysis => 'Nutrition analysis';

  @override
  String get authFullName => 'Full name';

  @override
  String get authTermsAgree => 'I have read and accept the terms';

  @override
  String get authTermsOpen => 'Terms';

  @override
  String get termsPlaceholderBody =>
      'Terms of service will appear here. This is a placeholder screen for the MVP.';

  @override
  String get logout => 'Log out';

  @override
  String get freeTierBadge => 'Free';

  @override
  String get premiumRecipeBadge => 'Premium';

  @override
  String get shoppingListTitle => 'Shopping List';

  @override
  String get shoppingListsTitle => 'Shopping lists';

  @override
  String get newShoppingList => 'New list';

  @override
  String get shoppingListNameLabel => 'List name';

  @override
  String get shoppingListNameHint => 'e.g. Weekend dinner, Party…';

  @override
  String get shoppingListDescriptionLabel => 'Description';

  @override
  String get shoppingListDescriptionHint => 'Optional — what is this list for?';

  @override
  String get createShoppingList => 'Create list';

  @override
  String get saveList => 'Save';

  @override
  String get editShoppingList => 'Edit list';

  @override
  String get deleteShoppingList => 'Delete list';

  @override
  String get deleteShoppingListConfirm => 'Delete this list and all its items?';

  @override
  String get cannotDeleteLastList => 'You need at least one shopping list.';

  @override
  String get chooseListForRecipe => 'Add missing ingredients to';

  @override
  String get confirmAddToList => 'Add to list';

  @override
  String listItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String shoppingListProgress(int bought, int total) {
    return '$bought / $total done';
  }

  @override
  String get emptyListDetailTitle => 'Nothing here yet';

  @override
  String get emptyListDetailBody =>
      'Add missing ingredients from a recipe, or use another list.';

  @override
  String get shoppingListNotFoundTitle => 'Shopping list not found';

  @override
  String get shoppingListNotFoundBody =>
      'This list may have been deleted or is no longer available.';

  @override
  String get goBack => 'Go back';

  @override
  String get cancel => 'Cancel';

  @override
  String get shareTooltip => 'Share';

  @override
  String get listCopied => 'List copied to clipboard!';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get dietaryPreferencesTitle => 'Dietary Preferences';

  @override
  String get dietaryLimitFreeHint =>
      'On Free plan you can select up to 2 preferences';

  @override
  String get dietVegan => 'Vegan';

  @override
  String get dietVegetarian => 'Vegetarian';

  @override
  String get dietKeto => 'Keto';

  @override
  String get dietGlutenFree => 'Gluten-free';

  @override
  String get dietHalal => 'Halal';

  @override
  String get dietNoDairy => 'No dairy';

  @override
  String itemsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items left',
      one: '1 item left',
    );
    return '$_temp0';
  }

  @override
  String itemsCompleted(int bought, int total) {
    return '$bought / $total completed';
  }

  @override
  String get emptyShoppingTitle => 'Shopping List is Empty';

  @override
  String get emptyShoppingBody =>
      'Pick a recipe and add missing ingredients\nto your list automatically.';

  @override
  String get goToRecipes => 'Go to Recipes';

  @override
  String get emptyShoppingTip =>
      'On the recipe screen, tap \"Select This Recipe\" to add missing items to your list.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionFeatures => 'Features';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionAbout => 'About';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get rateApp => 'Rate the App';

  @override
  String get shareFriends => 'Share with Friends';

  @override
  String get version => 'Version';

  @override
  String get userLabel => 'User';

  @override
  String get freePlan => 'Free Plan';

  @override
  String get premiumPlan => '⭐ Premium';

  @override
  String get goPremium => 'Go Premium';

  @override
  String get premiumPrice => '\$4.99/mo';

  @override
  String get premiumBullet1 => '🤖 AI recipe personalization';

  @override
  String get premiumBullet2 => '📊 Detailed nutrition tracking';

  @override
  String get premiumBullet3 => '🔄 Unlimited inventory';

  @override
  String get premiumBullet4 => '📅 Weekly meal planning';

  @override
  String get tryFree7Days => 'Try Free — 7 Days';

  @override
  String get premiumMemberTitle => 'You are a Premium Member';

  @override
  String get premiumMemberSubtitle => 'All features unlocked';

  @override
  String get upgradedPremium => 'Upgraded to Premium! 🎉';

  @override
  String get featInventory => 'Inventory Tracking';

  @override
  String get featRecipes => 'Recipe Suggestions';

  @override
  String get featShopping => 'Shopping List';

  @override
  String get featAiPhoto => 'AI Photo Recognition';

  @override
  String get featAiPersonal => 'AI Personalization';

  @override
  String get featNutrition => 'Nutrition Tracking';

  @override
  String get featWeekly => 'Weekly Planning';

  @override
  String get featUnlimited => 'Unlimited Recipes';

  @override
  String get proBadge => 'PRO';

  @override
  String get upgradeSheetTitle => 'Go Premium';

  @override
  String get upgradeSheetSubtitle =>
      'AI recipe suggestions, nutrition tracking, and more.';

  @override
  String get upgradeSheetCta => 'Try 7 Days Free — \$4.99/mo';

  @override
  String get notNow => 'Not Now';

  @override
  String get addToPantryTitle => 'Add to Pantry';

  @override
  String get tabPhoto => 'Photo';

  @override
  String get tabManual => 'Manual';

  @override
  String itemsAddedToPantry(int count) {
    return '$count items added to pantry!';
  }

  @override
  String get cameraPreview => 'Camera Preview';

  @override
  String get cameraHint =>
      'Photograph your ingredients\nand let AI identify them';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromLibrary => 'Choose from Library';

  @override
  String get aiPhotoTip =>
      'AI will automatically detect ingredients in the photo and add them to your list.';

  @override
  String itemsDetectedBanner(int count) {
    return '$count items detected! Edit and add them.';
  }

  @override
  String get retake => 'Retake';

  @override
  String addAllCount(int count) {
    return 'Add All ($count)';
  }

  @override
  String get itemName => 'Item Name';

  @override
  String get nameHint => 'e.g. Tomatoes, Eggs...';

  @override
  String get quantity => 'Quantity';

  @override
  String get addToPantryButton => 'Add to Pantry';

  @override
  String get quickAdd => 'Quick Add';

  @override
  String itemAdded(String name) {
    return '$name added!';
  }

  @override
  String get nutritionEstimated => 'Nutrition (estimated)';

  @override
  String get calories => 'Calories';

  @override
  String get protein => 'Protein';

  @override
  String get carbs => 'Carbs';

  @override
  String get fat => 'Fat';

  @override
  String get kcal => 'kcal';

  @override
  String get ingredientsSection => 'Ingredients';

  @override
  String get instructionsSection => 'Instructions';

  @override
  String missingCountShort(int count) {
    return '$count missing';
  }

  @override
  String get legendHave => 'Have it';

  @override
  String get legendMissing => 'Missing';

  @override
  String missingIngredientsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count missing ingredients',
      one: '1 missing ingredient',
    );
    return '$_temp0 — you can add them to your list';
  }

  @override
  String get allIngredientsAvailable =>
      'All ingredients are available in your pantry!';

  @override
  String selectRecipeWithMissing(int count) {
    return 'Select This Recipe  ($count missing → added to list)';
  }

  @override
  String get selectRecipe => 'Select This Recipe';

  @override
  String get sheetReadyTitle => 'Ready to Cook!';

  @override
  String get sheetSelectedTitle => 'Recipe Selected!';

  @override
  String sheetReadyBody(String recipeName) {
    return 'You have everything needed\nfor $recipeName. Enjoy!';
  }

  @override
  String sheetAddedBody(int count, String recipeName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count missing ingredients',
      one: '1 missing ingredient',
    );
    return '$_temp0 for $recipeName\nadded to your shopping list.';
  }

  @override
  String get done => 'Done';

  @override
  String get generalGroup => 'General';

  @override
  String get recipeR1Name => 'Shakshuka Eggs';

  @override
  String get recipeR2Name => 'Chicken Sauté';

  @override
  String get recipeR3Name => 'Cheese Omelette';

  @override
  String get recipeR4Name => 'French Fries';

  @override
  String get recipeR5Name => 'Garlic Chicken';

  @override
  String get recipeR1Step0 => 'Finely chop the onion and sauté in olive oil.';

  @override
  String get recipeR1Step1 =>
      'Dice the pepper and tomato, add to the pan and sauté.';

  @override
  String get recipeR1Step2 => 'Crack in the eggs and stir to combine.';

  @override
  String get recipeR1Step3 =>
      'Cook on low heat, season with salt and black pepper.';

  @override
  String get recipeR1Step4 => 'Serve hot.';

  @override
  String get recipeR2Step0 => 'Cut the chicken into bite-sized cubes.';

  @override
  String get recipeR2Step1 => 'Sauté the onion and garlic in olive oil.';

  @override
  String get recipeR2Step2 => 'Add the chicken and sear on all sides.';

  @override
  String get recipeR2Step3 =>
      'Add tomato and pepper, season with salt and black pepper.';

  @override
  String get recipeR2Step4 => 'Cover and simmer on low heat for 15 minutes.';

  @override
  String get recipeR2Step5 => 'Finish with dried thyme and serve hot.';

  @override
  String get recipeR3Step0 => 'Whisk the eggs together with salt.';

  @override
  String get recipeR3Step1 => 'Melt the butter in a non-stick pan.';

  @override
  String get recipeR3Step2 => 'Pour in the egg mixture.';

  @override
  String get recipeR3Step3 =>
      'Once the base sets, sprinkle grated cheese on one side.';

  @override
  String get recipeR3Step4 => 'Fold and transfer to a plate.';

  @override
  String get recipeR4Step0 => 'Peel the potatoes and cut into strips.';

  @override
  String get recipeR4Step1 => 'Pat them thoroughly dry with paper towels.';

  @override
  String get recipeR4Step2 => 'Fry in hot oil until golden.';

  @override
  String get recipeR4Step3 =>
      'Drain the oil and sprinkle with salt immediately.';

  @override
  String get recipeR4Step4 => 'Serve hot.';

  @override
  String get recipeR5Step0 =>
      'Combine garlic, olive oil and lemon juice as a marinade for the chicken.';

  @override
  String get recipeR5Step1 => 'Marinate for 30 minutes.';

  @override
  String get recipeR5Step2 => 'Preheat the oven to 200°C.';

  @override
  String get recipeR5Step3 => 'Sprinkle with thyme and salt.';

  @override
  String get recipeR5Step4 => 'Roast for 25–30 minutes.';

  @override
  String get ingEggs => 'Eggs';

  @override
  String get ingTomato => 'Tomato';

  @override
  String get ingGreenPepper => 'Green Pepper';

  @override
  String get ingOnion => 'Onion';

  @override
  String get ingOliveOil => 'Olive Oil';

  @override
  String get ingChicken => 'Chicken';

  @override
  String get ingGarlic => 'Garlic';

  @override
  String get ingRedPepper => 'Red Pepper';

  @override
  String get ingCheese => 'Cheese';

  @override
  String get ingButter => 'Butter';

  @override
  String get ingSalt => 'Salt';

  @override
  String get ingPotato => 'Potato';

  @override
  String get ingSunflowerOil => 'Sunflower Oil';

  @override
  String get ingLemon => 'Lemon';

  @override
  String get ingThyme => 'Thyme';

  @override
  String get ingCucumber => 'Cucumber';

  @override
  String get ingParsley => 'Parsley';

  @override
  String get ingBroccoli => 'Broccoli';

  @override
  String get ingMilk => 'Milk';

  @override
  String get ingBread => 'Bread';

  @override
  String get ingBanana => 'Banana';

  @override
  String get ingApple => 'Apple';

  @override
  String get amtToTaste => 'To taste';

  @override
  String get unitPcs => 'pcs';

  @override
  String get unitG => 'g';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMl => 'ml';

  @override
  String get unitL => 'L';

  @override
  String get unitBunch => 'bunch';

  @override
  String get unitBox => 'box';

  @override
  String get unitBottle => 'bottle';

  @override
  String get unitCloves => 'cloves';

  @override
  String get unitHead => 'head';

  @override
  String get unitTbsp => 'tbsp';

  @override
  String get unitTsp => 'tsp';

  @override
  String get unitMlLong => 'ml';

  @override
  String get langEnglish => 'English';

  @override
  String get langSpanish => 'Spanish';

  @override
  String get langTurkish => 'Turkish';

  @override
  String get authScreenTitle => 'Account';

  @override
  String get authHeadlineSignIn => 'Welcome back';

  @override
  String get authHeadlineSignUp => 'Create your account';

  @override
  String get authSubSignIn => 'Sign in to sync your kitchen across devices.';

  @override
  String get authSubSignUp => 'Join Meal Prep and plan smarter meals.';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authSignInButton => 'Sign In';

  @override
  String get authSignUpButton => 'Sign Up';

  @override
  String get authToggleNoAccount => 'Don\'t have an account?';

  @override
  String get authToggleHasAccount => 'Already have an account?';

  @override
  String get authToggleSignUp => 'Sign up';

  @override
  String get authToggleSignIn => 'Sign in';

  @override
  String get authOrWith => 'or continue with';

  @override
  String get authContinueGoogle => 'Google';

  @override
  String get authContinueApple => 'Apple';

  @override
  String get authUiOnlySnack => 'This screen is UI-only for now.';

  @override
  String get addManualIngredientFab => 'Add ingredient';

  @override
  String get shoppingIngredientNameLabel => 'Item name';

  @override
  String get shoppingIngredientNameHint => 'e.g. tomatoes, milk…';

  @override
  String get shoppingUnitFieldLabel => 'Unit';

  @override
  String get shoppingAddIngredientButton => 'Add';

  @override
  String get shoppingBoughtSemantics => 'Bought';

  @override
  String get shoppingDeleteItemTooltip => 'Delete';

  @override
  String get manualShoppingGroup => 'Added manually';

  @override
  String get shoppingNameRequired => 'Enter an item name';

  @override
  String get shoppingQuantityInvalid => 'Enter a quantity greater than 0';

  @override
  String get addToShoppingListShort => 'Add to shopping list';
}
