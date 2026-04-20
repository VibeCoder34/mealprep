import 'data/default_recipes.dart';
import 'models/inventory_item.dart';
import 'models/recipe.dart';
import 'models/shopping_item.dart';
import 'models/shopping_list_bundle.dart';

class MockData {
  static List<InventoryItem> get initialInventory => [
        const InventoryItem(id: '1', name: 'Eggs', emoji: '🥚', quantity: 6, unit: 'pcs'),
        const InventoryItem(id: '2', name: 'Tomato', emoji: '🍅', quantity: 4, unit: 'pcs'),
        const InventoryItem(id: '3', name: 'Cheese', emoji: '🧀', quantity: 200, unit: 'g'),
        const InventoryItem(id: '4', name: 'Chicken', emoji: '🍗', quantity: 500, unit: 'g'),
        const InventoryItem(id: '5', name: 'Onion', emoji: '🧅', quantity: 3, unit: 'pcs'),
        const InventoryItem(id: '6', name: 'Olive Oil', emoji: '🫙', quantity: 1, unit: 'bottle'),
        const InventoryItem(id: '7', name: 'Garlic', emoji: '🧄', quantity: 1, unit: 'head'),
        const InventoryItem(id: '8', name: 'Potato', emoji: '🥔', quantity: 5, unit: 'pcs'),
      ];

  static List<Recipe> get recipes => DefaultRecipes.all;

  static Recipe? recipeById(String id) {
    for (final r in DefaultRecipes.all) {
      if (r.id == id) return r;
    }
    return null;
  }

  static List<ShoppingItem> get _seedShoppingItems => [
        const ShoppingItem(
          id: 's1',
          name: 'Rice',
          amount: '1 cup dry',
          recipeId: 'recipe_1',
        ),
        const ShoppingItem(
          id: 's2',
          name: 'Beef',
          amount: '400 g',
          recipeId: 'recipe_2',
        ),
        const ShoppingItem(
          id: 's3',
          name: 'Butter',
          amount: '100 g',
          recipeId: 'recipe_10',
          isBought: true,
        ),
        const ShoppingItem(
          id: 's4',
          name: 'Salt',
          amount: '1 box',
          recipeId: 'general',
        ),
        const ShoppingItem(
          id: 's5',
          name: 'Fish Fillet',
          amount: '250 g',
          recipeId: 'recipe_3',
        ),
        const ShoppingItem(
          id: 's6',
          name: 'Lemon',
          amount: '2 pcs',
          recipeId: 'recipe_3',
          isBought: true,
        ),
        const ShoppingItem(
          id: 's7',
          name: 'Tofu',
          amount: '200 g',
          recipeId: 'recipe_4',
        ),
      ];

  static List<ShoppingListBundle> get initialShoppingLists => [
        ShoppingListBundle(
          id: 'sl_default',
          name: 'Weekly shop',
          description: 'Ingredients from recipes and pantry gaps.',
          items: List.from(_seedShoppingItems),
        ),
      ];
}
