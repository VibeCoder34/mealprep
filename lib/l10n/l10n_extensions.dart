import 'app_localizations.dart';
import '../mock_data.dart';

extension MealPrepL10nX on AppLocalizations {
  /// Localized display name for a [recipeId], or falls back to [MockData] / id.
  String recipeNameById(String id) {
    final r = MockData.recipeById(id);
    if (r != null) return r.name;
    switch (id) {
      case 'r1':
        return recipeR1Name;
      case 'r2':
        return recipeR2Name;
      case 'r3':
        return recipeR3Name;
      case 'r4':
        return recipeR4Name;
      case 'r5':
        return recipeR5Name;
      default:
        return id;
    }
  }

  String recipeStepLine(String recipeId, int index) {
    final r = MockData.recipeById(recipeId);
    if (r != null && index >= 0 && index < r.steps.length) {
      return r.steps[index];
    }
    switch (recipeId) {
      case 'r1':
        switch (index) {
          case 0:
            return recipeR1Step0;
          case 1:
            return recipeR1Step1;
          case 2:
            return recipeR1Step2;
          case 3:
            return recipeR1Step3;
          case 4:
            return recipeR1Step4;
        }
        break;
      case 'r2':
        switch (index) {
          case 0:
            return recipeR2Step0;
          case 1:
            return recipeR2Step1;
          case 2:
            return recipeR2Step2;
          case 3:
            return recipeR2Step3;
          case 4:
            return recipeR2Step4;
          case 5:
            return recipeR2Step5;
        }
        break;
      case 'r3':
        switch (index) {
          case 0:
            return recipeR3Step0;
          case 1:
            return recipeR3Step1;
          case 2:
            return recipeR3Step2;
          case 3:
            return recipeR3Step3;
          case 4:
            return recipeR3Step4;
        }
        break;
      case 'r4':
        switch (index) {
          case 0:
            return recipeR4Step0;
          case 1:
            return recipeR4Step1;
          case 2:
            return recipeR4Step2;
          case 3:
            return recipeR4Step3;
          case 4:
            return recipeR4Step4;
        }
        break;
      case 'r5':
        switch (index) {
          case 0:
            return recipeR5Step0;
          case 1:
            return recipeR5Step1;
          case 2:
            return recipeR5Step2;
          case 3:
            return recipeR5Step3;
          case 4:
            return recipeR5Step4;
        }
        break;
    }
    return '';
  }

  String ingredientLabel(String englishName) {
    switch (englishName) {
      case 'Eggs':
        return ingEggs;
      case 'Tomato':
        return ingTomato;
      case 'Green Pepper':
        return ingGreenPepper;
      case 'Onion':
        return ingOnion;
      case 'Olive Oil':
        return ingOliveOil;
      case 'Chicken':
        return ingChicken;
      case 'Garlic':
        return ingGarlic;
      case 'Red Pepper':
        return ingRedPepper;
      case 'Cheese':
        return ingCheese;
      case 'Butter':
        return ingButter;
      case 'Salt':
        return ingSalt;
      case 'Potato':
        return ingPotato;
      case 'Sunflower Oil':
        return ingSunflowerOil;
      case 'Lemon':
        return ingLemon;
      case 'Thyme':
        return ingThyme;
      case 'Cucumber':
        return ingCucumber;
      case 'Parsley':
        return ingParsley;
      default:
        return englishName;
    }
  }

  String unitLabel(String code) {
    switch (code) {
      case 'pcs':
        return unitPcs;
      case 'g':
        return unitG;
      case 'kg':
        return unitKg;
      case 'ml':
        return unitMl;
      case 'L':
        return unitL;
      case 'bunch':
        return unitBunch;
      case 'box':
        return unitBox;
      case 'bottle':
        return unitBottle;
      case 'cloves':
        return unitCloves;
      case 'head':
        return unitHead;
      default:
        return code;
    }
  }

  String shoppingGroupTitle(String recipeId) {
    if (recipeId == 'general') return generalGroup;
    if (recipeId == 'manual') return manualShoppingGroup;
    return recipeNameById(recipeId);
  }

  String categoryLabel(String categoryKey) {
    switch (categoryKey) {
      case 'all':
        return categoryAll;
      case 'breakfast':
        return categoryBreakfast;
      case 'dinner':
        return categoryDinner;
      case 'snack':
        return categorySnack;
      case 'high_protein':
        return categoryHighProtein;
      case 'vegan':
        return categoryVeganFilter;
      case 'low_carb':
        return categoryLowCarb;
      case 'quick':
        return categoryQuick;
      case 'lunch':
        return categoryLunch;
      default:
        return categoryKey;
    }
  }

  String dietLabelForKey(String key) {
    switch (key) {
      case 'vegan':
        return dietVegan;
      case 'vegetarian':
        return dietVegetarian;
      case 'keto':
        return dietKeto;
      case 'gluten_free':
        return dietGlutenFree;
      case 'halal':
        return dietHalal;
      case 'no_dairy':
        return dietNoDairy;
      case 'high_protein':
        return dietHighProtein;
      case 'low_carb':
        return dietLowCarb;
      default:
        return key;
    }
  }

  /// Localizes fixed recipe amount tokens like [To taste].
  String formatIngredientAmount(String amount) {
    if (amount == 'To taste') return amtToTaste;
    return amount;
  }

  /// Localized difficulty label; [difficulty] is Turkish from data ("Kolay", "Orta").
  String difficultyLabel(String difficulty) {
    switch (difficulty) {
      case 'Kolay':
        return difficultyEasy;
      case 'Orta':
        return difficultyMedium;
      default:
        return difficulty;
    }
  }
}
