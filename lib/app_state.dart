import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/inventory_item.dart';
import 'models/recipe_user_rating.dart';
import 'models/shopping_item.dart';
import 'models/shopping_list_bundle.dart';
import 'mock_data.dart';

class AppState extends ChangeNotifier {
  static const _dietPrefsKey = 'dietary_preference_keys_v2';
  static const _premiumKey = 'mock_is_premium';
  final List<InventoryItem> _inventory = List.from(MockData.initialInventory);
  final List<ShoppingListBundle> _shoppingLists =
      List.from(MockData.initialShoppingLists);
  final List<String> _savedRecipeIds = [];
  final Map<String, RecipeUserRating> _recipeRatings = {};
  List<String> _dietaryPreferences = const [];
  String? _preferredShoppingListId;
  bool _isPremium = false;

  AppState() {
    if (_shoppingLists.isNotEmpty) {
      _preferredShoppingListId = _shoppingLists.first.id;
    }
    _loadDietaryPreferences();
    _loadPremium();
  }

  List<InventoryItem> get inventory => List.unmodifiable(_inventory);
  List<ShoppingListBundle> get shoppingLists => List.unmodifiable(_shoppingLists);

  ShoppingListBundle? shoppingListById(String id) {
    try {
      return _shoppingLists.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  String? get preferredShoppingListId => _preferredShoppingListId;

  String? get defaultTargetListId {
    if (_shoppingLists.isEmpty) return null;
    if (_preferredShoppingListId != null &&
        _shoppingLists.any((l) => l.id == _preferredShoppingListId)) {
      return _preferredShoppingListId;
    }
    return _shoppingLists.first.id;
  }

  bool get isPremium => _isPremium;

  List<String> get dietaryPreferences => List.unmodifiable(_dietaryPreferences);

  bool hasDietaryPreference(String tag) => _dietaryPreferences.contains(tag);

  /// Returns `true` if toggle succeeded, `false` if blocked (free limit).
  Future<bool> toggleDietaryPreference(String tag) async {
    final next = List<String>.from(_dietaryPreferences);
    if (next.contains(tag)) {
      next.remove(tag);
    } else {
      if (!_isPremium && next.length >= 2) return false;
      next.add(tag);
    }
    _dietaryPreferences = List.unmodifiable(next);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_dietPrefsKey, _dietaryPreferences);
    return true;
  }

  Future<void> _loadDietaryPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_dietPrefsKey);
    if (stored == null) return;
    _dietaryPreferences = List.unmodifiable(stored);
    notifyListeners();
  }

  List<String> get savedRecipeIds => List.unmodifiable(_savedRecipeIds);

  bool isRecipeSaved(String recipeId) => _savedRecipeIds.contains(recipeId);

  /// Returns `true` if toggle succeeded, `false` if blocked (free limit).
  bool toggleSavedRecipe(String recipeId) {
    if (_savedRecipeIds.contains(recipeId)) {
      _savedRecipeIds.remove(recipeId);
      notifyListeners();
      return true;
    }
    if (!_isPremium && _savedRecipeIds.length >= 3) {
      return false;
    }
    _savedRecipeIds.add(recipeId);
    notifyListeners();
    return true;
  }

  RecipeUserRating? ratingForRecipe(String recipeId) => _recipeRatings[recipeId];

  void setRecipeRating(String recipeId, {required int rating, String comment = ''}) {
    final r = rating.clamp(1, 5);
    _recipeRatings[recipeId] = RecipeUserRating(
      rating: r,
      comment: comment.trim(),
    );
    notifyListeners();
  }

  void removeRecipeRating(String recipeId) {
    if (_recipeRatings.remove(recipeId) != null) {
      notifyListeners();
    }
  }

  void setPreferredShoppingList(String id) {
    if (_shoppingLists.any((l) => l.id == id)) {
      _preferredShoppingListId = id;
      notifyListeners();
    }
  }

  void addItem(InventoryItem item) {
    final idx = _inventory.indexWhere(
      (i) => i.name.toLowerCase() == item.name.toLowerCase(),
    );
    if (idx >= 0) {
      _inventory[idx] = _inventory[idx].copyWith(
        quantity: _inventory[idx].quantity + item.quantity,
      );
    } else {
      _inventory.add(item);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _inventory.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void toggleShoppingItem(String listId, String itemId) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final items = list.items.map((i) {
      if (i.id == itemId) {
        return i.copyWith(isBought: !i.isBought);
      }
      return i;
    }).toList();
    _shoppingLists[lidx] = list.copyWith(items: items);
    notifyListeners();
  }

  /// Manual entry: always appends (same name can appear with different amounts).
  void addManualShoppingItem(String listId, ShoppingItem item) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = List<ShoppingItem>.from(list.items)..add(item);
    _shoppingLists[lidx] = list.copyWith(items: next);
    _preferredShoppingListId = listId;
    notifyListeners();
  }

  void removeShoppingItem(String listId, String itemId) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = list.items.where((i) => i.id != itemId).toList();
    _shoppingLists[lidx] = list.copyWith(items: next);
    notifyListeners();
  }

  void addShoppingItems(String listId, List<ShoppingItem> items) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = List<ShoppingItem>.from(list.items);
    for (final item in items) {
      final exists = next.any(
        (i) =>
            i.name.toLowerCase() == item.name.toLowerCase() &&
            i.recipeId == item.recipeId,
      );
      if (!exists) {
        next.add(item);
      }
    }
    _shoppingLists[lidx] = list.copyWith(items: next);
    _preferredShoppingListId = listId;
    notifyListeners();
  }

  String createShoppingList({
    required String name,
    String description = '',
  }) {
    final id = 'sl_${DateTime.now().millisecondsSinceEpoch}';
    _shoppingLists.add(
      ShoppingListBundle(
        id: id,
        name: name.trim().isEmpty ? '—' : name.trim(),
        description: description.trim(),
      ),
    );
    _preferredShoppingListId = id;
    notifyListeners();
    return id;
  }

  void updateShoppingListMeta(
    String id, {
    required String name,
    required String description,
  }) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == id);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    _shoppingLists[lidx] = list.copyWith(
      name: name.trim().isEmpty ? list.name : name.trim(),
      description: description.trim(),
    );
    notifyListeners();
  }

  /// Returns `false` if this was the last list (it is kept).
  bool deleteShoppingList(String id) {
    if (_shoppingLists.length <= 1) return false;
    final removedPreferred = _preferredShoppingListId == id;
    _shoppingLists.removeWhere((l) => l.id == id);
    if (removedPreferred || !_shoppingLists.any((l) => l.id == _preferredShoppingListId)) {
      _preferredShoppingListId = _shoppingLists.first.id;
    }
    notifyListeners();
    return true;
  }

  Future<void> _loadPremium() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
    notifyListeners();
  }

  Future<void> upgradeToPremium() async {
    _isPremium = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, true);
  }
}
