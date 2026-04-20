import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'models/inventory_item.dart';
import 'models/recipe.dart';
import 'models/recipe_user_rating.dart';
import 'models/shopping_item.dart';
import 'models/shopping_list_bundle.dart';
import 'services/database_service.dart';
import 'services/recipe_service.dart';
import 'services/supabase_service.dart';

class AppState extends ChangeNotifier {
  static const _dietPrefsKey = 'dietary_preference_keys_v2';
  static const _premiumKey = 'mock_is_premium';
  static const _inventoryKey = 'app_inventory_v1';
  static const _shoppingListsKey = 'app_shopping_lists_v1';
  static const _preferredShoppingListIdKey = 'app_preferred_shopping_list_id_v1';
  static const _savedRecipeIdsKey = 'app_saved_recipe_ids_v1';
  static const _recipeRatingsKey = 'app_recipe_ratings_v1';
  static const _recipesKey = 'app_recipes_cache_v1';

  final List<InventoryItem> _inventory = [];
  final List<ShoppingListBundle> _shoppingLists = [];
  final List<Recipe> _recipes = [];
  final List<String> _savedRecipeIds = [];
  final Map<String, RecipeUserRating> _recipeRatings = {};
  List<String> _dietaryPreferences = const [];
  String? _preferredShoppingListId;
  bool _isPremium = false;
  bool _isSyncingBackend = false;
  String? _lastBackendSyncError;
  bool _recipesLoading = false;
  String? _recipesLoadError;

  final RecipeService _recipeService = RecipeService(Supabase.instance.client);

  AppState() {
    _loadCoreData();
    _loadDietaryPreferences();
    _loadPremium();
    Future<void>.microtask(_bootstrap);
  }

  Future<void> _bootstrap() async {
    await loadRecipes();
    await _loadFromBackendIfLoggedIn();
  }

  List<InventoryItem> get inventory => List.unmodifiable(_inventory);
  List<ShoppingListBundle> get shoppingLists => List.unmodifiable(_shoppingLists);
  List<Recipe> get recipes => List.unmodifiable(_recipes);
  bool get isSyncingBackend => _isSyncingBackend;
  String? get lastBackendSyncError => _lastBackendSyncError;
  bool get recipesLoading => _recipesLoading;
  String? get recipesLoadError => _recipesLoadError;

  Future<void> refreshFromBackend() async {
    await loadRecipes();
    await _loadFromBackendIfLoggedIn(force: true);
  }

  /// Loads recipe catalog from Supabase (respects premium + dietary preferences).
  Future<void> loadRecipes() async {
    _recipesLoading = true;
    _recipesLoadError = null;
    notifyListeners();
    try {
      final list = await _recipeService.getRecipes(
        isPremiumUser: _isPremium,
        dietaryFilters:
            _dietaryPreferences.isNotEmpty ? List<String>.from(_dietaryPreferences) : null,
      );
      _recipes
        ..clear()
        ..addAll(list);
      await _persistRecipesCache();
    } catch (_) {
      _recipesLoadError = 'recipes_load_failed';
    } finally {
      _recipesLoading = false;
      notifyListeners();
    }
  }

  Future<Recipe?> fetchRecipeById(String id) => _recipeService.getRecipeById(id);

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
    await loadRecipes();
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

  String? get _userId => SupabaseService.instance.currentUser?.id;

  /// Returns `true` if toggle succeeded, `false` if blocked (free limit).
  Future<bool> toggleSavedRecipe(String recipeId) async {
    if (_savedRecipeIds.contains(recipeId)) {
      _savedRecipeIds.remove(recipeId);
      notifyListeners();
      _persistSavedRecipes();
      final uid = _userId;
      if (uid != null) {
        try {
          await DatabaseService.instance.unsaveRecipe(userId: uid, recipeId: recipeId);
        } catch (_) {}
      }
      return true;
    }
    if (!_isPremium && _savedRecipeIds.length >= 3) {
      return false;
    }
    _savedRecipeIds.add(recipeId);
    notifyListeners();
    _persistSavedRecipes();
    final uid = _userId;
    if (uid != null) {
      try {
        await DatabaseService.instance.saveRecipe(userId: uid, recipeId: recipeId);
      } catch (_) {}
    }
    return true;
  }

  RecipeUserRating? ratingForRecipe(String recipeId) => _recipeRatings[recipeId];

  Future<void> setRecipeRating(String recipeId, {required int rating, String comment = ''}) async {
    final r = rating.clamp(1, 5);
    _recipeRatings[recipeId] = RecipeUserRating(
      rating: r,
      comment: comment.trim(),
    );
    notifyListeners();
    _persistRecipeRatings();
    final uid = _userId;
    if (uid != null) {
      try {
        await DatabaseService.instance.upsertRecipeRating(
          userId: uid,
          recipeId: recipeId,
          rating: r,
          comment: comment.trim(),
        );
      } catch (_) {}
    }
  }

  Future<void> removeRecipeRating(String recipeId) async {
    if (_recipeRatings.remove(recipeId) != null) {
      notifyListeners();
      _persistRecipeRatings();
      final uid = _userId;
      if (uid != null) {
        try {
          await DatabaseService.instance.deleteRecipeRating(userId: uid, recipeId: recipeId);
        } catch (_) {}
      }
    }
  }

  void setPreferredShoppingList(String id) {
    if (_shoppingLists.any((l) => l.id == id)) {
      _preferredShoppingListId = id;
      notifyListeners();
      _persistPreferredShoppingListId();
    }
  }

  Future<void> addItem(InventoryItem item) async {
    final uid = _userId;
    if (uid == null) {
      // Fallback to local-only if not logged in.
      _inventory.add(item);
      notifyListeners();
      _persistInventory();
      return;
    }

    try {
      final inserted = await DatabaseService.instance.addInventoryItem(
        userId: uid,
        itemName: item.name,
        emoji: item.emoji,
        quantity: item.quantity,
        unit: item.unit,
      );
      final serverItem = InventoryItem(
        id: inserted['id']?.toString() ?? item.id,
        name: inserted['item_name']?.toString() ?? item.name,
        emoji: inserted['emoji']?.toString() ?? item.emoji,
        quantity: (inserted['quantity'] as num?)?.toInt() ?? item.quantity,
        unit: inserted['unit']?.toString() ?? item.unit,
      );
      _inventory.insert(0, serverItem);
      notifyListeners();
      _persistInventory();
    } catch (_) {
      // If backend fails, keep local item.
      _inventory.insert(0, item);
      notifyListeners();
      _persistInventory();
    }
  }

  Future<void> removeItem(String id) async {
    _inventory.removeWhere((i) => i.id == id);
    notifyListeners();
    _persistInventory();
    final uid = _userId;
    if (uid != null) {
      try {
        await DatabaseService.instance.deleteInventoryItem(id: id, userId: uid);
      } catch (_) {}
    }
  }

  Future<void> toggleShoppingItem(String listId, String itemId) async {
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
    _persistShoppingLists();

    ShoppingItem? updated;
    for (final it in items) {
      if (it.id == itemId) {
        updated = it;
        break;
      }
    }
    if (updated != null && updated.id.isNotEmpty) {
      try {
        await DatabaseService.instance.setShoppingListPurchased(
          itemId: updated.id,
          isPurchased: updated.isBought,
        );
      } catch (_) {}
    }
  }

  /// Manual entry: always appends (same name can appear with different amounts).
  Future<void> addManualShoppingItem(String listId, ShoppingItem item) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    try {
      final inserted = await DatabaseService.instance.addShoppingListItem(
        listId: listId,
        itemName: item.name,
        amount: item.amount,
        isPurchased: false,
        source: 'manual',
        recipeId: null,
      );
      final serverItem = ShoppingItem(
        id: inserted['id']?.toString() ?? item.id,
        name: inserted['item_name']?.toString() ?? item.name,
        amount: inserted['amount']?.toString() ?? item.amount,
        recipeId: inserted['recipe_id']?.toString() ?? 'manual',
        isBought: (inserted['is_purchased'] as bool?) ?? false,
      );
      final next = List<ShoppingItem>.from(list.items)..add(serverItem);
      _shoppingLists[lidx] = list.copyWith(items: next);
      _preferredShoppingListId = listId;
      notifyListeners();
      _persistShoppingLists();
      _persistPreferredShoppingListId();
    } catch (_) {
      final next = List<ShoppingItem>.from(list.items)..add(item);
      _shoppingLists[lidx] = list.copyWith(items: next);
      _preferredShoppingListId = listId;
      notifyListeners();
      _persistShoppingLists();
      _persistPreferredShoppingListId();
    }
  }

  Future<void> removeShoppingItem(String listId, String itemId) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = list.items.where((i) => i.id != itemId).toList();
    _shoppingLists[lidx] = list.copyWith(items: next);
    notifyListeners();
    _persistShoppingLists();
    try {
      await DatabaseService.instance.deleteShoppingListItem(itemId: itemId);
    } catch (_) {}
  }

  Future<void> addShoppingItems(String listId, List<ShoppingItem> items) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = List<ShoppingItem>.from(list.items);
    for (final item in items) {
      final exists = next.any(
        (i) => i.name.toLowerCase() == item.name.toLowerCase() && i.recipeId == item.recipeId,
      );
      if (exists) continue;
      try {
        final inserted = await DatabaseService.instance.addShoppingListItem(
          listId: listId,
          itemName: item.name,
          amount: item.amount,
          isPurchased: item.isBought,
          source: 'recipe',
          recipeId: item.recipeId,
        );
        next.add(
          ShoppingItem(
            id: inserted['id']?.toString() ?? item.id,
            name: inserted['item_name']?.toString() ?? item.name,
            amount: inserted['amount']?.toString() ?? item.amount,
            recipeId: inserted['recipe_id']?.toString() ?? item.recipeId,
            isBought: (inserted['is_purchased'] as bool?) ?? item.isBought,
          ),
        );
      } catch (_) {
        next.add(item);
      }
    }
    _shoppingLists[lidx] = list.copyWith(items: next);
    _preferredShoppingListId = listId;
    notifyListeners();
    _persistShoppingLists();
    _persistPreferredShoppingListId();
  }

  Future<String> createShoppingList({
    required String name,
    String description = '',
  }) {
    final uid = _userId;
    final safeName = name.trim().isEmpty ? '—' : name.trim();
    final safeDesc = description.trim();

    if (uid == null) {
      final id = 'sl_${DateTime.now().millisecondsSinceEpoch}';
      _shoppingLists.add(
        ShoppingListBundle(id: id, name: safeName, description: safeDesc),
      );
      _preferredShoppingListId = id;
      notifyListeners();
      _persistShoppingLists();
      _persistPreferredShoppingListId();
      return Future.value(id);
    }

    return DatabaseService.instance
        .createShoppingList(userId: uid, name: safeName, description: safeDesc)
        .then((row) {
      final id = row['id']?.toString() ?? 'sl_${DateTime.now().millisecondsSinceEpoch}';
      _shoppingLists.insert(
        0,
        ShoppingListBundle(id: id, name: row['name']?.toString() ?? safeName, description: row['description']?.toString() ?? safeDesc),
      );
      _preferredShoppingListId = id;
      notifyListeners();
      _persistShoppingLists();
      _persistPreferredShoppingListId();
      return id;
    }).catchError((_) {
      final id = 'sl_${DateTime.now().millisecondsSinceEpoch}';
      _shoppingLists.insert(0, ShoppingListBundle(id: id, name: safeName, description: safeDesc));
      _preferredShoppingListId = id;
      notifyListeners();
      _persistShoppingLists();
      _persistPreferredShoppingListId();
      return id;
    });
  }

  Future<void> updateShoppingListMeta(
    String id, {
    required String name,
    required String description,
  }) {
    final lidx = _shoppingLists.indexWhere((l) => l.id == id);
    if (lidx < 0) return Future.value();
    final list = _shoppingLists[lidx];
    _shoppingLists[lidx] = list.copyWith(
      name: name.trim().isEmpty ? list.name : name.trim(),
      description: description.trim(),
    );
    notifyListeners();
    _persistShoppingLists();

    final uid = _userId;
    if (uid != null) {
      return DatabaseService.instance.updateShoppingListMeta(
        id: id,
        userId: uid,
        name: _shoppingLists[lidx].name,
        description: _shoppingLists[lidx].description,
      );
    }
    return Future.value();
  }

  /// Returns `false` if this was the last list (it is kept).
  Future<bool> deleteShoppingList(String id) async {
    if (_shoppingLists.length <= 1) return false;
    final removedPreferred = _preferredShoppingListId == id;
    _shoppingLists.removeWhere((l) => l.id == id);
    if (removedPreferred || !_shoppingLists.any((l) => l.id == _preferredShoppingListId)) {
      _preferredShoppingListId = _shoppingLists.first.id;
    }
    notifyListeners();
    _persistShoppingLists();
    _persistPreferredShoppingListId();
    final uid = _userId;
    if (uid != null) {
      try {
        await DatabaseService.instance.deleteShoppingList(id: id, userId: uid);
      } catch (_) {}
    }
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
    await loadRecipes();
  }

  Future<void> _loadCoreData() async {
    final prefs = await SharedPreferences.getInstance();

    final invRaw = prefs.getString(_inventoryKey);
    if (invRaw != null && invRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(invRaw);
        if (decoded is List) {
          _inventory
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((m) => Map<String, Object?>.from(m))
                  .map(InventoryItem.fromJson),
            );
        }
      } catch (_) {}
    }

    final listsRaw = prefs.getString(_shoppingListsKey);
    if (listsRaw != null && listsRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(listsRaw);
        if (decoded is List) {
          _shoppingLists
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((m) => Map<String, Object?>.from(m))
                  .map(ShoppingListBundle.fromJson),
            );
        }
      } catch (_) {}
    }

    if (_shoppingLists.isNotEmpty) {
      final preferred = prefs.getString(_preferredShoppingListIdKey);
      if (preferred != null && _shoppingLists.any((l) => l.id == preferred)) {
        _preferredShoppingListId = preferred;
      } else {
        _preferredShoppingListId ??= _shoppingLists.first.id;
      }
    } else {
      _preferredShoppingListId = null;
    }

    final savedIds = prefs.getStringList(_savedRecipeIdsKey);
    if (savedIds != null) {
      _savedRecipeIds
        ..clear()
        ..addAll(savedIds);
    }

    final ratingsRaw = prefs.getString(_recipeRatingsKey);
    if (ratingsRaw != null && ratingsRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(ratingsRaw);
        if (decoded is Map) {
          _recipeRatings
            ..clear()
            ..addAll(
              decoded.map(
                (k, v) => MapEntry(
                  k.toString(),
                  RecipeUserRating.fromJson(Map<String, Object?>.from(v as Map)),
                ),
              ),
            );
        }
      } catch (_) {}
    }

    final recipesRaw = prefs.getString(_recipesKey);
    if (recipesRaw != null && recipesRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(recipesRaw);
        if (decoded is List) {
          _recipes
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((m) => Map<String, Object?>.from(m))
                  .map(Recipe.fromJson),
            );
        }
      } catch (_) {}
    }

    notifyListeners();
  }

  Future<void> _loadFromBackendIfLoggedIn({bool force = false}) async {
    final uid = _userId;
    if (uid == null) return;

    if (_isSyncingBackend) return;
    _isSyncingBackend = true;
    if (force) _lastBackendSyncError = null;
    notifyListeners();

    var hadAnyError = false;
    try {
      try {
        // Inventory
        final inv = await DatabaseService.instance.fetchInventory(userId: uid);
        _inventory
          ..clear()
          ..addAll(
            inv.map(
              (r) => InventoryItem(
                id: r['id']?.toString() ?? '',
                name: r['item_name']?.toString() ?? '',
                emoji: r['emoji']?.toString() ?? '🍽️',
                quantity: (r['quantity'] as num?)?.toInt() ?? 0,
                unit: r['unit']?.toString() ?? 'pcs',
              ),
            ),
          );
        _persistInventory();
      } catch (_) {
        hadAnyError = true;
      }

      try {
        // Shopping lists + items
        final listRows = await DatabaseService.instance.fetchShoppingLists(userId: uid);
        final bundles = <ShoppingListBundle>[];
        for (final l in listRows) {
          final listId = l['id']?.toString() ?? '';
          final itemsRows = listId.isEmpty
              ? <Map<String, dynamic>>[]
              : await DatabaseService.instance.fetchShoppingListItems(listId: listId);
          final items = itemsRows
              .map(
                (r) => ShoppingItem(
                  id: r['id']?.toString() ?? '',
                  name: r['item_name']?.toString() ?? '',
                  amount: r['amount']?.toString() ?? '',
                  recipeId: r['recipe_id']?.toString() ?? (r['source']?.toString() == 'manual' ? 'manual' : 'general'),
                  isBought: (r['is_purchased'] as bool?) ?? false,
                ),
              )
              .toList(growable: false);
          bundles.add(
            ShoppingListBundle(
              id: listId,
              name: l['name']?.toString() ?? '—',
              description: l['description']?.toString() ?? '',
              items: items,
            ),
          );
        }
        _shoppingLists
          ..clear()
          ..addAll(bundles);
        if (_shoppingLists.isNotEmpty) {
          _preferredShoppingListId ??= _shoppingLists.first.id;
        }
        _persistShoppingLists();
        _persistPreferredShoppingListId();
      } catch (_) {
        hadAnyError = true;
      }

      try {
        // Saved recipes
        final rows = await DatabaseService.instance.fetchSavedRecipes(userId: uid);
        _savedRecipeIds
          ..clear()
          ..addAll(rows.map((r) => r['recipe_id']?.toString() ?? '').where((s) => s.isNotEmpty));
        _persistSavedRecipes();
      } catch (_) {
        hadAnyError = true;
      }

      try {
        // Ratings
        final rows = await DatabaseService.instance.fetchRecipeRatings(userId: uid);
        _recipeRatings
          ..clear()
          ..addEntries(
            rows.map((r) {
              final id = r['recipe_id']?.toString() ?? '';
              final rating = (r['rating'] as num?)?.toInt() ?? 0;
              final comment = r['comment']?.toString() ?? '';
              return MapEntry(id, RecipeUserRating(rating: rating, comment: comment));
            }).where((e) => e.key.isNotEmpty && e.value.rating > 0),
          );
        _persistRecipeRatings();
      } catch (_) {
        hadAnyError = true;
      }
    } finally {
      _isSyncingBackend = false;
      _lastBackendSyncError = hadAnyError ? 'Some data could not be loaded from the server.' : null;
      notifyListeners();
    }
  }

  Future<void> _persistRecipesCache() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_recipes.map((r) => r.toJson()).toList(growable: false));
    await prefs.setString(_recipesKey, encoded);
  }

  Future<void> _persistInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_inventory.map((i) => i.toJson()).toList(growable: false));
    await prefs.setString(_inventoryKey, encoded);
  }

  Future<void> _persistShoppingLists() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_shoppingLists.map((l) => l.toJson()).toList(growable: false));
    await prefs.setString(_shoppingListsKey, encoded);
  }

  Future<void> _persistPreferredShoppingListId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = _preferredShoppingListId;
    if (id == null) {
      await prefs.remove(_preferredShoppingListIdKey);
    } else {
      await prefs.setString(_preferredShoppingListIdKey, id);
    }
  }

  Future<void> _persistSavedRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_savedRecipeIdsKey, List<String>.from(_savedRecipeIds));
  }

  Future<void> _persistRecipeRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _recipeRatings.map((k, v) => MapEntry(k, v.toJson())),
    );
    await prefs.setString(_recipeRatingsKey, encoded);
  }
}
