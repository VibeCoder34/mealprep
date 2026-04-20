import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Prep'**
  String get appTitle;

  /// No description provided for @navPantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get navPantry;

  /// No description provided for @navRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get navRecipes;

  /// No description provided for @navShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get navShopping;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Organize Your Kitchen'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Track your pantry by snapping a photo\nor adding items manually.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Recipes'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Get personalized recipe ideas\nbased on what you already have.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Shopping List'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'Missing ingredients are listed\nautomatically. Easy to share too.'**
  String get onboarding3Body;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go'**
  String get letsGo;

  /// No description provided for @myKitchen.
  ///
  /// In en, this message translates to:
  /// **'My Kitchen'**
  String get myKitchen;

  /// No description provided for @yourPantry.
  ///
  /// In en, this message translates to:
  /// **'Your Pantry'**
  String get yourPantry;

  /// No description provided for @totalItemsCount.
  ///
  /// In en, this message translates to:
  /// **'Total: {count} items'**
  String totalItemsCount(int count);

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @addToPantry.
  ///
  /// In en, this message translates to:
  /// **'Add to Pantry'**
  String get addToPantry;

  /// No description provided for @takePhotoOrManual.
  ///
  /// In en, this message translates to:
  /// **'Take a photo or add manually'**
  String get takePhotoOrManual;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @lowInventoryHint.
  ///
  /// In en, this message translates to:
  /// **'Add more items to discover more recipes'**
  String get lowInventoryHint;

  /// No description provided for @addMoreShort.
  ///
  /// In en, this message translates to:
  /// **'Add →'**
  String get addMoreShort;

  /// No description provided for @pantryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Pantry is Empty'**
  String get pantryEmpty;

  /// No description provided for @pantryEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start adding your kitchen items to discover personalized recipes.'**
  String get pantryEmptySubtitle;

  /// No description provided for @addFirstItem.
  ///
  /// In en, this message translates to:
  /// **'Add Your First Item'**
  String get addFirstItem;

  /// No description provided for @recipeSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Recipe Suggestions'**
  String get recipeSuggestions;

  /// No description provided for @noPantryItems.
  ///
  /// In en, this message translates to:
  /// **'No items in your pantry'**
  String get noPantryItems;

  /// No description provided for @noPantryItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add kitchen items to your pantry first\nto get personalized recipe suggestions.'**
  String get noPantryItemsSubtitle;

  /// No description provided for @addItemsButton.
  ///
  /// In en, this message translates to:
  /// **'Add Items'**
  String get addItemsButton;

  /// No description provided for @discoverRecipes.
  ///
  /// In en, this message translates to:
  /// **'Discover Recipes'**
  String get discoverRecipes;

  /// No description provided for @personalizedRecipesBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll create personalized recipes\nbased on your {count} pantry items.'**
  String personalizedRecipesBody(int count);

  /// No description provided for @generateRecipes.
  ///
  /// In en, this message translates to:
  /// **'Generate Recipes'**
  String get generateRecipes;

  /// No description provided for @fromPantry.
  ///
  /// In en, this message translates to:
  /// **'From Pantry'**
  String get fromPantry;

  /// No description provided for @quickRecipes.
  ///
  /// In en, this message translates to:
  /// **'Quick Recipes'**
  String get quickRecipes;

  /// No description provided for @withPantryItemsCount.
  ///
  /// In en, this message translates to:
  /// **'With {count} items in your pantry'**
  String withPantryItemsCount(int count);

  /// No description provided for @recipesFoundCount.
  ///
  /// In en, this message translates to:
  /// **'{count} recipes found!'**
  String recipesFoundCount(int count);

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @noRecipesInCategory.
  ///
  /// In en, this message translates to:
  /// **'No recipes found in this category'**
  String get noRecipesInCategory;

  /// No description provided for @prepTimeMin.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String prepTimeMin(int n);

  /// No description provided for @recipeCardAllAvailable.
  ///
  /// In en, this message translates to:
  /// **'All ingredients available ✓'**
  String get recipeCardAllAvailable;

  /// No description provided for @recipeCardPartial.
  ///
  /// In en, this message translates to:
  /// **'{available}/{total} available  ·  {missing} missing'**
  String recipeCardPartial(int available, int total, int missing);

  /// No description provided for @savedRecipesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Recipes'**
  String get savedRecipesTitle;

  /// No description provided for @premiumUnlimitedSavedRecipes.
  ///
  /// In en, this message translates to:
  /// **'Unlimited saved recipes for Premium'**
  String get premiumUnlimitedSavedRecipes;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @collectionsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get collectionsAll;

  /// No description provided for @rateRecipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateRecipeTitle;

  /// No description provided for @addCommentLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Comment'**
  String get addCommentLabel;

  /// No description provided for @ratingSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get ratingSave;

  /// No description provided for @ratingDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get ratingDelete;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get categoryBreakfast;

  /// No description provided for @categoryDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get categoryDinner;

  /// No description provided for @categorySnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get categorySnack;

  /// No description provided for @categoryHighProtein.
  ///
  /// In en, this message translates to:
  /// **'High protein'**
  String get categoryHighProtein;

  /// No description provided for @categoryVeganFilter.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get categoryVeganFilter;

  /// No description provided for @categoryLowCarb.
  ///
  /// In en, this message translates to:
  /// **'Low carb'**
  String get categoryLowCarb;

  /// No description provided for @categoryQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick'**
  String get categoryQuick;

  /// No description provided for @categoryLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get categoryLunch;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// No description provided for @dietHighProtein.
  ///
  /// In en, this message translates to:
  /// **'High protein'**
  String get dietHighProtein;

  /// No description provided for @dietLowCarb.
  ///
  /// In en, this message translates to:
  /// **'Low carb'**
  String get dietLowCarb;

  /// No description provided for @premiumFeatureTitle.
  ///
  /// In en, this message translates to:
  /// **'This feature is part of Premium'**
  String get premiumFeatureTitle;

  /// No description provided for @premiumFeatureDefaultBody.
  ///
  /// In en, this message translates to:
  /// **'Unlock AI tools, weekly planning, and unlimited filters and saves.'**
  String get premiumFeatureDefaultBody;

  /// No description provided for @upgradeToPremiumCta.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremiumCta;

  /// No description provided for @premiumUnlimitedFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited filters on Premium'**
  String get premiumUnlimitedFiltersTitle;

  /// No description provided for @premiumUnlimitedFiltersBody.
  ///
  /// In en, this message translates to:
  /// **'Pick as many dietary filters as you need with Premium.'**
  String get premiumUnlimitedFiltersBody;

  /// No description provided for @premiumUnlimitedSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited saves on Premium'**
  String get premiumUnlimitedSavedTitle;

  /// No description provided for @premiumUnlimitedSavedBody.
  ///
  /// In en, this message translates to:
  /// **'Save as many recipes as you want with Premium.'**
  String get premiumUnlimitedSavedBody;

  /// No description provided for @featAiRecipeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create recipe (AI)'**
  String get featAiRecipeCreate;

  /// No description provided for @featMacroOptimize.
  ///
  /// In en, this message translates to:
  /// **'Optimize macros'**
  String get featMacroOptimize;

  /// No description provided for @featWeeklyMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Weekly meal plan'**
  String get featWeeklyMealPlan;

  /// No description provided for @featNutritionAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Nutrition analysis'**
  String get featNutritionAnalysis;

  /// No description provided for @authFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get authFullName;

  /// No description provided for @authTermsAgree.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept the terms'**
  String get authTermsAgree;

  /// No description provided for @authTermsOpen.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get authTermsOpen;

  /// No description provided for @termsPlaceholderBody.
  ///
  /// In en, this message translates to:
  /// **'Terms of service will appear here. This is a placeholder screen for the MVP.'**
  String get termsPlaceholderBody;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @freeTierBadge.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get freeTierBadge;

  /// No description provided for @premiumRecipeBadge.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumRecipeBadge;

  /// No description provided for @shoppingListTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping List'**
  String get shoppingListTitle;

  /// No description provided for @shoppingListsTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping lists'**
  String get shoppingListsTitle;

  /// No description provided for @newShoppingList.
  ///
  /// In en, this message translates to:
  /// **'New list'**
  String get newShoppingList;

  /// No description provided for @shoppingListNameLabel.
  ///
  /// In en, this message translates to:
  /// **'List name'**
  String get shoppingListNameLabel;

  /// No description provided for @shoppingListNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Weekend dinner, Party…'**
  String get shoppingListNameHint;

  /// No description provided for @shoppingListDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get shoppingListDescriptionLabel;

  /// No description provided for @shoppingListDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional — what is this list for?'**
  String get shoppingListDescriptionHint;

  /// No description provided for @createShoppingList.
  ///
  /// In en, this message translates to:
  /// **'Create list'**
  String get createShoppingList;

  /// No description provided for @saveList.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveList;

  /// No description provided for @editShoppingList.
  ///
  /// In en, this message translates to:
  /// **'Edit list'**
  String get editShoppingList;

  /// No description provided for @deleteShoppingList.
  ///
  /// In en, this message translates to:
  /// **'Delete list'**
  String get deleteShoppingList;

  /// No description provided for @deleteShoppingListConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this list and all its items?'**
  String get deleteShoppingListConfirm;

  /// No description provided for @cannotDeleteLastList.
  ///
  /// In en, this message translates to:
  /// **'You need at least one shopping list.'**
  String get cannotDeleteLastList;

  /// No description provided for @chooseListForRecipe.
  ///
  /// In en, this message translates to:
  /// **'Add missing ingredients to'**
  String get chooseListForRecipe;

  /// No description provided for @confirmAddToList.
  ///
  /// In en, this message translates to:
  /// **'Add to list'**
  String get confirmAddToList;

  /// No description provided for @listItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 item} other{{count} items}}'**
  String listItemsCount(int count);

  /// No description provided for @shoppingListProgress.
  ///
  /// In en, this message translates to:
  /// **'{bought} / {total} done'**
  String shoppingListProgress(int bought, int total);

  /// No description provided for @emptyListDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyListDetailTitle;

  /// No description provided for @emptyListDetailBody.
  ///
  /// In en, this message translates to:
  /// **'Add missing ingredients from a recipe, or use another list.'**
  String get emptyListDetailBody;

  /// No description provided for @shoppingListNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping list not found'**
  String get shoppingListNotFoundTitle;

  /// No description provided for @shoppingListNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This list may have been deleted or is no longer available.'**
  String get shoppingListNotFoundBody;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @shareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTooltip;

  /// No description provided for @listCopied.
  ///
  /// In en, this message translates to:
  /// **'List copied to clipboard!'**
  String get listCopied;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @dietaryPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preferences'**
  String get dietaryPreferencesTitle;

  /// No description provided for @dietaryLimitFreeHint.
  ///
  /// In en, this message translates to:
  /// **'On Free plan you can select up to 2 preferences'**
  String get dietaryLimitFreeHint;

  /// No description provided for @dietVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get dietVegan;

  /// No description provided for @dietVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get dietVegetarian;

  /// No description provided for @dietKeto.
  ///
  /// In en, this message translates to:
  /// **'Keto'**
  String get dietKeto;

  /// No description provided for @dietGlutenFree.
  ///
  /// In en, this message translates to:
  /// **'Gluten-free'**
  String get dietGlutenFree;

  /// No description provided for @dietHalal.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get dietHalal;

  /// No description provided for @dietNoDairy.
  ///
  /// In en, this message translates to:
  /// **'No dairy'**
  String get dietNoDairy;

  /// No description provided for @itemsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 item left} other{{count} items left}}'**
  String itemsLeft(int count);

  /// No description provided for @itemsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{bought} / {total} completed'**
  String itemsCompleted(int bought, int total);

  /// No description provided for @emptyShoppingTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping List is Empty'**
  String get emptyShoppingTitle;

  /// No description provided for @emptyShoppingBody.
  ///
  /// In en, this message translates to:
  /// **'Pick a recipe and add missing ingredients\nto your list automatically.'**
  String get emptyShoppingBody;

  /// No description provided for @goToRecipes.
  ///
  /// In en, this message translates to:
  /// **'Go to Recipes'**
  String get goToRecipes;

  /// No description provided for @emptyShoppingTip.
  ///
  /// In en, this message translates to:
  /// **'On the recipe screen, tap \"Select This Recipe\" to add missing items to your list.'**
  String get emptyShoppingTip;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @sectionFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get sectionFeatures;

  /// No description provided for @sectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get sectionGeneral;

  /// No description provided for @sectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the App'**
  String get rateApp;

  /// No description provided for @shareFriends.
  ///
  /// In en, this message translates to:
  /// **'Share with Friends'**
  String get shareFriends;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @userLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userLabel;

  /// No description provided for @freePlan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlan;

  /// No description provided for @premiumPlan.
  ///
  /// In en, this message translates to:
  /// **'⭐ Premium'**
  String get premiumPlan;

  /// No description provided for @goPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get goPremium;

  /// No description provided for @premiumPrice.
  ///
  /// In en, this message translates to:
  /// **'\$4.99/mo'**
  String get premiumPrice;

  /// No description provided for @premiumBullet1.
  ///
  /// In en, this message translates to:
  /// **'🤖 AI recipe personalization'**
  String get premiumBullet1;

  /// No description provided for @premiumBullet2.
  ///
  /// In en, this message translates to:
  /// **'📊 Detailed nutrition tracking'**
  String get premiumBullet2;

  /// No description provided for @premiumBullet3.
  ///
  /// In en, this message translates to:
  /// **'🔄 Unlimited inventory'**
  String get premiumBullet3;

  /// No description provided for @premiumBullet4.
  ///
  /// In en, this message translates to:
  /// **'📅 Weekly meal planning'**
  String get premiumBullet4;

  /// No description provided for @tryFree7Days.
  ///
  /// In en, this message translates to:
  /// **'Try Free — 7 Days'**
  String get tryFree7Days;

  /// No description provided for @premiumMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'You are a Premium Member'**
  String get premiumMemberTitle;

  /// No description provided for @premiumMemberSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All features unlocked'**
  String get premiumMemberSubtitle;

  /// No description provided for @upgradedPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgraded to Premium! 🎉'**
  String get upgradedPremium;

  /// No description provided for @featInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory Tracking'**
  String get featInventory;

  /// No description provided for @featRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipe Suggestions'**
  String get featRecipes;

  /// No description provided for @featShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping List'**
  String get featShopping;

  /// No description provided for @featAiPhoto.
  ///
  /// In en, this message translates to:
  /// **'AI Photo Recognition'**
  String get featAiPhoto;

  /// No description provided for @featAiPersonal.
  ///
  /// In en, this message translates to:
  /// **'AI Personalization'**
  String get featAiPersonal;

  /// No description provided for @featNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Tracking'**
  String get featNutrition;

  /// No description provided for @featWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly Planning'**
  String get featWeekly;

  /// No description provided for @featUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Recipes'**
  String get featUnlimited;

  /// No description provided for @proBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proBadge;

  /// No description provided for @upgradeSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get upgradeSheetTitle;

  /// No description provided for @upgradeSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI recipe suggestions, nutrition tracking, and more.'**
  String get upgradeSheetSubtitle;

  /// No description provided for @upgradeSheetCta.
  ///
  /// In en, this message translates to:
  /// **'Try 7 Days Free — \$4.99/mo'**
  String get upgradeSheetCta;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @addToPantryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to Pantry'**
  String get addToPantryTitle;

  /// No description provided for @tabPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get tabPhoto;

  /// No description provided for @tabManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get tabManual;

  /// No description provided for @itemsAddedToPantry.
  ///
  /// In en, this message translates to:
  /// **'{count} items added to pantry!'**
  String itemsAddedToPantry(int count);

  /// No description provided for @cameraPreview.
  ///
  /// In en, this message translates to:
  /// **'Camera Preview'**
  String get cameraPreview;

  /// No description provided for @cameraHint.
  ///
  /// In en, this message translates to:
  /// **'Photograph your ingredients\nand let AI identify them'**
  String get cameraHint;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromLibrary.
  ///
  /// In en, this message translates to:
  /// **'Choose from Library'**
  String get chooseFromLibrary;

  /// No description provided for @aiPhotoTip.
  ///
  /// In en, this message translates to:
  /// **'AI will automatically detect ingredients in the photo and add them to your list.'**
  String get aiPhotoTip;

  /// No description provided for @itemsDetectedBanner.
  ///
  /// In en, this message translates to:
  /// **'{count} items detected! Edit and add them.'**
  String itemsDetectedBanner(int count);

  /// No description provided for @retake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retake;

  /// No description provided for @addAllCount.
  ///
  /// In en, this message translates to:
  /// **'Add All ({count})'**
  String addAllCount(int count);

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Tomatoes, Eggs...'**
  String get nameHint;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @addToPantryButton.
  ///
  /// In en, this message translates to:
  /// **'Add to Pantry'**
  String get addToPantryButton;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAdd;

  /// No description provided for @itemAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} added!'**
  String itemAdded(String name);

  /// No description provided for @nutritionEstimated.
  ///
  /// In en, this message translates to:
  /// **'Nutrition (estimated)'**
  String get nutritionEstimated;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get protein;

  /// No description provided for @carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get carbs;

  /// No description provided for @fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get fat;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @ingredientsSection.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredientsSection;

  /// No description provided for @instructionsSection.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructionsSection;

  /// No description provided for @missingCountShort.
  ///
  /// In en, this message translates to:
  /// **'{count} missing'**
  String missingCountShort(int count);

  /// No description provided for @legendHave.
  ///
  /// In en, this message translates to:
  /// **'Have it'**
  String get legendHave;

  /// No description provided for @legendMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get legendMissing;

  /// No description provided for @missingIngredientsBanner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 missing ingredient} other{{count} missing ingredients}} — you can add them to your list'**
  String missingIngredientsBanner(int count);

  /// No description provided for @allIngredientsAvailable.
  ///
  /// In en, this message translates to:
  /// **'All ingredients are available in your pantry!'**
  String get allIngredientsAvailable;

  /// No description provided for @selectRecipeWithMissing.
  ///
  /// In en, this message translates to:
  /// **'Select This Recipe  ({count} missing → added to list)'**
  String selectRecipeWithMissing(int count);

  /// No description provided for @selectRecipe.
  ///
  /// In en, this message translates to:
  /// **'Select This Recipe'**
  String get selectRecipe;

  /// No description provided for @sheetReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to Cook!'**
  String get sheetReadyTitle;

  /// No description provided for @sheetSelectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe Selected!'**
  String get sheetSelectedTitle;

  /// No description provided for @sheetReadyBody.
  ///
  /// In en, this message translates to:
  /// **'You have everything needed\nfor {recipeName}. Enjoy!'**
  String sheetReadyBody(String recipeName);

  /// No description provided for @sheetAddedBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 missing ingredient} other{{count} missing ingredients}} for {recipeName}\nadded to your shopping list.'**
  String sheetAddedBody(int count, String recipeName);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @generalGroup.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalGroup;

  /// No description provided for @recipeR1Name.
  ///
  /// In en, this message translates to:
  /// **'Shakshuka Eggs'**
  String get recipeR1Name;

  /// No description provided for @recipeR2Name.
  ///
  /// In en, this message translates to:
  /// **'Chicken Sauté'**
  String get recipeR2Name;

  /// No description provided for @recipeR3Name.
  ///
  /// In en, this message translates to:
  /// **'Cheese Omelette'**
  String get recipeR3Name;

  /// No description provided for @recipeR4Name.
  ///
  /// In en, this message translates to:
  /// **'French Fries'**
  String get recipeR4Name;

  /// No description provided for @recipeR5Name.
  ///
  /// In en, this message translates to:
  /// **'Garlic Chicken'**
  String get recipeR5Name;

  /// No description provided for @recipeR1Step0.
  ///
  /// In en, this message translates to:
  /// **'Finely chop the onion and sauté in olive oil.'**
  String get recipeR1Step0;

  /// No description provided for @recipeR1Step1.
  ///
  /// In en, this message translates to:
  /// **'Dice the pepper and tomato, add to the pan and sauté.'**
  String get recipeR1Step1;

  /// No description provided for @recipeR1Step2.
  ///
  /// In en, this message translates to:
  /// **'Crack in the eggs and stir to combine.'**
  String get recipeR1Step2;

  /// No description provided for @recipeR1Step3.
  ///
  /// In en, this message translates to:
  /// **'Cook on low heat, season with salt and black pepper.'**
  String get recipeR1Step3;

  /// No description provided for @recipeR1Step4.
  ///
  /// In en, this message translates to:
  /// **'Serve hot.'**
  String get recipeR1Step4;

  /// No description provided for @recipeR2Step0.
  ///
  /// In en, this message translates to:
  /// **'Cut the chicken into bite-sized cubes.'**
  String get recipeR2Step0;

  /// No description provided for @recipeR2Step1.
  ///
  /// In en, this message translates to:
  /// **'Sauté the onion and garlic in olive oil.'**
  String get recipeR2Step1;

  /// No description provided for @recipeR2Step2.
  ///
  /// In en, this message translates to:
  /// **'Add the chicken and sear on all sides.'**
  String get recipeR2Step2;

  /// No description provided for @recipeR2Step3.
  ///
  /// In en, this message translates to:
  /// **'Add tomato and pepper, season with salt and black pepper.'**
  String get recipeR2Step3;

  /// No description provided for @recipeR2Step4.
  ///
  /// In en, this message translates to:
  /// **'Cover and simmer on low heat for 15 minutes.'**
  String get recipeR2Step4;

  /// No description provided for @recipeR2Step5.
  ///
  /// In en, this message translates to:
  /// **'Finish with dried thyme and serve hot.'**
  String get recipeR2Step5;

  /// No description provided for @recipeR3Step0.
  ///
  /// In en, this message translates to:
  /// **'Whisk the eggs together with salt.'**
  String get recipeR3Step0;

  /// No description provided for @recipeR3Step1.
  ///
  /// In en, this message translates to:
  /// **'Melt the butter in a non-stick pan.'**
  String get recipeR3Step1;

  /// No description provided for @recipeR3Step2.
  ///
  /// In en, this message translates to:
  /// **'Pour in the egg mixture.'**
  String get recipeR3Step2;

  /// No description provided for @recipeR3Step3.
  ///
  /// In en, this message translates to:
  /// **'Once the base sets, sprinkle grated cheese on one side.'**
  String get recipeR3Step3;

  /// No description provided for @recipeR3Step4.
  ///
  /// In en, this message translates to:
  /// **'Fold and transfer to a plate.'**
  String get recipeR3Step4;

  /// No description provided for @recipeR4Step0.
  ///
  /// In en, this message translates to:
  /// **'Peel the potatoes and cut into strips.'**
  String get recipeR4Step0;

  /// No description provided for @recipeR4Step1.
  ///
  /// In en, this message translates to:
  /// **'Pat them thoroughly dry with paper towels.'**
  String get recipeR4Step1;

  /// No description provided for @recipeR4Step2.
  ///
  /// In en, this message translates to:
  /// **'Fry in hot oil until golden.'**
  String get recipeR4Step2;

  /// No description provided for @recipeR4Step3.
  ///
  /// In en, this message translates to:
  /// **'Drain the oil and sprinkle with salt immediately.'**
  String get recipeR4Step3;

  /// No description provided for @recipeR4Step4.
  ///
  /// In en, this message translates to:
  /// **'Serve hot.'**
  String get recipeR4Step4;

  /// No description provided for @recipeR5Step0.
  ///
  /// In en, this message translates to:
  /// **'Combine garlic, olive oil and lemon juice as a marinade for the chicken.'**
  String get recipeR5Step0;

  /// No description provided for @recipeR5Step1.
  ///
  /// In en, this message translates to:
  /// **'Marinate for 30 minutes.'**
  String get recipeR5Step1;

  /// No description provided for @recipeR5Step2.
  ///
  /// In en, this message translates to:
  /// **'Preheat the oven to 200°C.'**
  String get recipeR5Step2;

  /// No description provided for @recipeR5Step3.
  ///
  /// In en, this message translates to:
  /// **'Sprinkle with thyme and salt.'**
  String get recipeR5Step3;

  /// No description provided for @recipeR5Step4.
  ///
  /// In en, this message translates to:
  /// **'Roast for 25–30 minutes.'**
  String get recipeR5Step4;

  /// No description provided for @ingEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get ingEggs;

  /// No description provided for @ingTomato.
  ///
  /// In en, this message translates to:
  /// **'Tomato'**
  String get ingTomato;

  /// No description provided for @ingGreenPepper.
  ///
  /// In en, this message translates to:
  /// **'Green Pepper'**
  String get ingGreenPepper;

  /// No description provided for @ingOnion.
  ///
  /// In en, this message translates to:
  /// **'Onion'**
  String get ingOnion;

  /// No description provided for @ingOliveOil.
  ///
  /// In en, this message translates to:
  /// **'Olive Oil'**
  String get ingOliveOil;

  /// No description provided for @ingChicken.
  ///
  /// In en, this message translates to:
  /// **'Chicken'**
  String get ingChicken;

  /// No description provided for @ingGarlic.
  ///
  /// In en, this message translates to:
  /// **'Garlic'**
  String get ingGarlic;

  /// No description provided for @ingRedPepper.
  ///
  /// In en, this message translates to:
  /// **'Red Pepper'**
  String get ingRedPepper;

  /// No description provided for @ingCheese.
  ///
  /// In en, this message translates to:
  /// **'Cheese'**
  String get ingCheese;

  /// No description provided for @ingButter.
  ///
  /// In en, this message translates to:
  /// **'Butter'**
  String get ingButter;

  /// No description provided for @ingSalt.
  ///
  /// In en, this message translates to:
  /// **'Salt'**
  String get ingSalt;

  /// No description provided for @ingPotato.
  ///
  /// In en, this message translates to:
  /// **'Potato'**
  String get ingPotato;

  /// No description provided for @ingSunflowerOil.
  ///
  /// In en, this message translates to:
  /// **'Sunflower Oil'**
  String get ingSunflowerOil;

  /// No description provided for @ingLemon.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get ingLemon;

  /// No description provided for @ingThyme.
  ///
  /// In en, this message translates to:
  /// **'Thyme'**
  String get ingThyme;

  /// No description provided for @ingCucumber.
  ///
  /// In en, this message translates to:
  /// **'Cucumber'**
  String get ingCucumber;

  /// No description provided for @ingParsley.
  ///
  /// In en, this message translates to:
  /// **'Parsley'**
  String get ingParsley;

  /// No description provided for @amtToTaste.
  ///
  /// In en, this message translates to:
  /// **'To taste'**
  String get amtToTaste;

  /// No description provided for @unitPcs.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get unitPcs;

  /// No description provided for @unitG.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitG;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitMl.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get unitMl;

  /// No description provided for @unitL.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get unitL;

  /// No description provided for @unitBunch.
  ///
  /// In en, this message translates to:
  /// **'bunch'**
  String get unitBunch;

  /// No description provided for @unitBox.
  ///
  /// In en, this message translates to:
  /// **'box'**
  String get unitBox;

  /// No description provided for @unitBottle.
  ///
  /// In en, this message translates to:
  /// **'bottle'**
  String get unitBottle;

  /// No description provided for @unitCloves.
  ///
  /// In en, this message translates to:
  /// **'cloves'**
  String get unitCloves;

  /// No description provided for @unitHead.
  ///
  /// In en, this message translates to:
  /// **'head'**
  String get unitHead;

  /// No description provided for @unitTbsp.
  ///
  /// In en, this message translates to:
  /// **'tbsp'**
  String get unitTbsp;

  /// No description provided for @unitTsp.
  ///
  /// In en, this message translates to:
  /// **'tsp'**
  String get unitTsp;

  /// No description provided for @unitMlLong.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get unitMlLong;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get langSpanish;

  /// No description provided for @langTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get langTurkish;

  /// No description provided for @authScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get authScreenTitle;

  /// No description provided for @authHeadlineSignIn.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authHeadlineSignIn;

  /// No description provided for @authHeadlineSignUp.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authHeadlineSignUp;

  /// No description provided for @authSubSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your kitchen across devices.'**
  String get authSubSignIn;

  /// No description provided for @authSubSignUp.
  ///
  /// In en, this message translates to:
  /// **'Join Meal Prep and plan smarter meals.'**
  String get authSubSignUp;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignInButton;

  /// No description provided for @authSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUpButton;

  /// No description provided for @authToggleNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authToggleNoAccount;

  /// No description provided for @authToggleHasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authToggleHasAccount;

  /// No description provided for @authToggleSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get authToggleSignUp;

  /// No description provided for @authToggleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authToggleSignIn;

  /// No description provided for @authOrWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get authOrWith;

  /// No description provided for @authContinueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get authContinueGoogle;

  /// No description provided for @authContinueApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get authContinueApple;

  /// No description provided for @authUiOnlySnack.
  ///
  /// In en, this message translates to:
  /// **'This screen is UI-only for now.'**
  String get authUiOnlySnack;

  /// No description provided for @addManualIngredientFab.
  ///
  /// In en, this message translates to:
  /// **'Add ingredient'**
  String get addManualIngredientFab;

  /// No description provided for @shoppingIngredientNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get shoppingIngredientNameLabel;

  /// No description provided for @shoppingIngredientNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. tomatoes, milk…'**
  String get shoppingIngredientNameHint;

  /// No description provided for @shoppingUnitFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get shoppingUnitFieldLabel;

  /// No description provided for @shoppingAddIngredientButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get shoppingAddIngredientButton;

  /// No description provided for @shoppingBoughtSemantics.
  ///
  /// In en, this message translates to:
  /// **'Bought'**
  String get shoppingBoughtSemantics;

  /// No description provided for @shoppingDeleteItemTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get shoppingDeleteItemTooltip;

  /// No description provided for @manualShoppingGroup.
  ///
  /// In en, this message translates to:
  /// **'Added manually'**
  String get manualShoppingGroup;

  /// No description provided for @shoppingNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an item name'**
  String get shoppingNameRequired;

  /// No description provided for @shoppingQuantityInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a quantity greater than 0'**
  String get shoppingQuantityInvalid;

  /// No description provided for @addToShoppingListShort.
  ///
  /// In en, this message translates to:
  /// **'Add to shopping list'**
  String get addToShoppingListShort;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
