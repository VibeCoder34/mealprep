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
import 'services/ingredient_normalizer.dart';
import 'services/unit_system.dart';

class AppState extends ChangeNotifier {
  static const _dietPrefsKey = 'dietary_preference_keys_v2';
  static const _premiumKey = 'mock_is_premium';
  static const _inventoryKey = 'app_inventory_v1';
  static const _shoppingListsKey = 'app_shopping_lists_v1';
  static const _preferredShoppingListIdKey = 'app_preferred_shopping_list_id_v1';
  static const _savedRecipeIdsKey = 'app_saved_recipe_ids_v1';
  static const _recipeRatingsKey = 'app_recipe_ratings_v1';
  static const _recipesKey = 'app_recipes_cache_v1';
  static const _customRecipesKey = 'app_custom_recipes_v1';

  final List<InventoryItem> _inventory = [];
  final List<ShoppingListBundle> _shoppingLists = [];
  final List<Recipe> _recipes = [];
  final List<Recipe> _customRecipes = [];
  final Map<String, Recipe> _aiDraftRecipesById = {};
  final List<String> _savedRecipeIds = [];
  final Map<String, RecipeUserRating> _recipeRatings = {};
  List<String> _dietaryPreferences = const [];
  String? _preferredShoppingListId;
  bool _isPremium = false;
  bool _isSyncingBackend = false;
  String? _lastBackendSyncError;
  bool _recipesLoading = false;
  String? _recipesLoadError;
  int _busyCount = 0;

  final RecipeService _recipeService = RecipeService(Supabase.instance.client);
  final IngredientNormalizer _ingredientNormalizer = const IngredientNormalizer();
  final UnitSystem _unitSystem = const UnitSystem();

  List<InventoryItem> _dedupeInventory(List<InventoryItem> items) {
    if (items.isEmpty) return items;

    // Merge by normalized key + unit group, keeping a stable display name and unit.
    final byKey = <String, InventoryItem>{};
    for (final it in items) {
      final key = (it.itemKey ?? _ingredientNormalizer.normalize(it.name)).trim();
      if (key.isEmpty) continue;
      final group = (it.unitGroup ?? _unitSystem.groupKey(_unitSystem.groupOf(it.unit))).trim();
      final compound = '$key|$group';

      final prev = byKey[compound];
      if (prev == null) {
        byKey[compound] = it.copyWith(itemKey: key, unitGroup: group);
        continue;
      }

      // Convert quantity into prev.unit when possible; otherwise keep the prev row.
      num added = it.quantity;
      if (prev.unit.trim().toLowerCase() != it.unit.trim().toLowerCase()) {
        final converted = _unitSystem.convert(it.quantity, fromUnit: it.unit, toUnit: prev.unit);
        if (converted == null) {
          // Not convertible inside same group (should be rare). Keep both by making a new compound key.
          final fallbackCompound = '$compound|${it.unit.trim().toLowerCase()}';
          byKey.putIfAbsent(fallbackCompound, () => it.copyWith(itemKey: key, unitGroup: group));
          continue;
        }
        added = converted;
      }

      byKey[compound] = prev.copyWith(
        quantity: (prev.quantity + added).round().clamp(0, 1 << 30),
        // keep prev.unit stable; prefer a richer display name if prev was normalized
        name: prev.name.trim().isEmpty ? it.name : prev.name,
        emoji: prev.emoji.trim().isEmpty ? it.emoji : prev.emoji,
        itemKey: key,
        unitGroup: group,
      );
    }

    final merged = byKey.values.toList(growable: false)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return merged;
  }

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
  List<Recipe> get customRecipes => List.unmodifiable(_customRecipes);
  /// Recipes visible in the UI (shared catalog + user-saved custom recipes).
  ///
  /// NOTE: AI drafts are not included here by default (they live in-memory).
  List<Recipe> get recipes => List.unmodifiable(<Recipe>[
        ..._customRecipes,
        ..._recipes,
      ]);
  bool get isSyncingBackend => _isSyncingBackend;
  String? get lastBackendSyncError => _lastBackendSyncError;
  bool get recipesLoading => _recipesLoading;
  String? get recipesLoadError => _recipesLoadError;
  bool get isBusy => _busyCount > 0;

  Future<T> _runBusy<T>(Future<T> Function() action) async {
    _busyCount += 1;
    notifyListeners();
    try {
      return await action();
    } finally {
      _busyCount = (_busyCount - 1).clamp(0, 1 << 30);
      notifyListeners();
    }
  }

  Future<void> refreshFromBackend() async {
    await loadRecipes();
    await _loadFromBackendIfLoggedIn(force: true);
  }

  /// Loads recipe catalog from Supabase (respects premium + dietary preferences).
  Future<void> loadRecipes() async {
    await _runBusy(() async {
      _recipesLoading = true;
      _recipesLoadError = null;
      notifyListeners();
      try {
        final list = await _recipeService.getRecipes(
          isPremiumUser: _isPremium,
          dietaryFilters:
              _dietaryPreferences.isNotEmpty ? List<String>.from(_dietaryPreferences) : null,
        );
        final withAvailability = _applyInventoryAvailability(list);
        _recipes
          ..clear()
          ..addAll(withAvailability);
        await _persistRecipesCache();
      } catch (_) {
        _recipesLoadError = 'recipes_load_failed';
      } finally {
        _recipesLoading = false;
        notifyListeners();
      }
    });
  }

  Future<Recipe?> fetchRecipeById(String id) async {
    final r = await _recipeService.getRecipeById(id);
    if (r == null) return null;
    return _applyInventoryAvailabilityToRecipe(r);
  }

  bool _ingredientMatchesInventory(String ingredientName, Set<String> inventorySet) {
    final ing = _ingredientNormalizer.normalize(ingredientName);
    if (ing.isEmpty) return false;
    if (inventorySet.contains(ing)) return true;
    // Substring heuristic to handle "büyük boy soğan" vs "soğan"
    for (final inv in inventorySet) {
      if (inv.isEmpty) continue;
      if (ing.contains(inv) || inv.contains(ing)) return true;
    }
    return false;
  }

  Recipe _applyInventoryAvailabilityToRecipe(Recipe recipe) {
    final inventorySet = _inventory
        .map((i) => _ingredientNormalizer.normalize(i.name))
        .where((s) => s.isNotEmpty)
        .toSet();

    final nextIngredients = recipe.ingredients
        .map(
          (ing) => RecipeIngredient(
            name: ing.name,
            amount: ing.amount,
            unit: ing.unit,
            isAvailable: _ingredientMatchesInventory(ing.name, inventorySet),
          ),
        )
        .toList(growable: false);

    return Recipe(
      id: recipe.id,
      name: recipe.name,
      emoji: recipe.emoji,
      category: recipe.category,
      cuisineType: recipe.cuisineType,
      servings: recipe.servings,
      prepTimeMinutes: recipe.prepTimeMinutes,
      categoryKey: recipe.categoryKey,
      ingredients: nextIngredients,
      nutrition: recipe.nutrition,
      collections: recipe.collections,
      dietaryTags: recipe.dietaryTags,
      allergens: recipe.allergens,
      source: recipe.source,
      isApproved: recipe.isApproved,
      status: recipe.status,
      isPremium: recipe.isPremium,
      difficulty: recipe.difficulty,
      steps: recipe.steps,
      createdAt: recipe.createdAt,
      updatedAt: recipe.updatedAt,
    );
  }

  List<Recipe> _applyInventoryAvailability(List<Recipe> recipes) {
    if (_inventory.isEmpty) {
      // Ensure consistent behavior: mark all as unavailable? No, keep defaults true.
      // Availability will be computed when inventory exists.
      return recipes;
    }
    return recipes.map(_applyInventoryAvailabilityToRecipe).toList(growable: false);
  }

  /// Returns a recipe if it exists locally (custom or AI draft).
  Recipe? localRecipeById(String id) {
    for (final r in _customRecipes) {
      if (r.id == id) return r;
    }
    return _aiDraftRecipesById[id];
  }

  /// Adds an in-memory AI recipe draft so screens can navigate by id.
  void upsertAiDraftRecipe(Recipe recipe) {
    _aiDraftRecipesById[recipe.id] = recipe;
    notifyListeners();
  }

  /// Persists a recipe as a custom recipe (visible in lists).
  Future<void> saveCustomRecipe(Recipe recipe) async {
    await _runBusy(() async {
      final uid = _userId;
      if (uid != null) {
        try {
          await DatabaseService.instance.upsertCustomRecipe(
            userId: uid,
            id: recipe.id,
            recipeJson: recipe.toJson(),
          );
        } catch (_) {
          // keep local fallback
        }
      }
      final next = <Recipe>[
        recipe,
        ..._customRecipes.where((r) => r.id != recipe.id),
      ];
      _customRecipes
        ..clear()
        ..addAll(next);
      notifyListeners();
      await _persistCustomRecipes();
    });
  }

  Future<void> updateCustomRecipe(Recipe recipe) async {
    final idx = _customRecipes.indexWhere((r) => r.id == recipe.id);
    if (idx < 0) return;
    _customRecipes[idx] = recipe;
    notifyListeners();
    await _persistCustomRecipes();
  }

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
    return _runBusy(() async {
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
    });
  }

  RecipeUserRating? ratingForRecipe(String recipeId) => _recipeRatings[recipeId];

  Future<void> setRecipeRating(String recipeId, {required int rating, String comment = ''}) async {
    await _runBusy(() async {
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
    });
  }

  Future<void> removeRecipeRating(String recipeId) async {
    await _runBusy(() async {
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
    });
  }

  void setPreferredShoppingList(String id) {
    if (_shoppingLists.any((l) => l.id == id)) {
      _preferredShoppingListId = id;
      notifyListeners();
      _persistPreferredShoppingListId();
    }
  }

  Future<void> addItem(InventoryItem item) async {
    final itemKey = item.itemKey ?? _ingredientNormalizer.normalize(item.name);
    final unitGroup = item.unitGroup ?? _unitSystem.groupKey(_unitSystem.groupOf(item.unit));
    final uid = _userId;
    if (uid == null) {
      // Fallback to local-only if not logged in.
      final existingIdx = _inventory.indexWhere(
        (i) => _ingredientNormalizer.normalize(i.name) == itemKey,
      );
      if (existingIdx >= 0) {
        final existing = _inventory[existingIdx];
        final existingGroup = existing.unitGroup ?? _unitSystem.groupKey(_unitSystem.groupOf(existing.unit));
        if (existingGroup != unitGroup) {
          throw StateError('unit_group_mismatch');
        }

        var addedQty = item.quantity.toDouble();
        if (existing.unit.trim().toLowerCase() != item.unit.trim().toLowerCase()) {
          final converted = _unitSystem.convert(
            item.quantity,
            fromUnit: item.unit,
            toUnit: existing.unit,
          );
          if (converted == null) {
            throw StateError('unit_convert_failed');
          }
          addedQty = converted.toDouble();
        }

        _inventory[existingIdx] = existing.copyWith(
          quantity: (existing.quantity + addedQty.round()).clamp(0, 1 << 30),
          // Keep existing.unit to avoid "unit flipping".
          emoji: item.emoji,
          name: item.name,
          itemKey: itemKey,
          unitGroup: unitGroup,
        );
      } else {
        _inventory.add(item.copyWith(itemKey: itemKey, unitGroup: unitGroup));
      }
      // Recompute availability for recipes shown in UI.
      _recomputeRecipeAvailability();
      notifyListeners();
      _persistInventory();
      return;
    }

    await _runBusy(() async {
      try {
        // If this item already exists locally, apply conversion + sum before upsert,
        // so backend always receives the merged quantity and the stable unit.
        final existingIdx = _inventory.indexWhere(
          (i) => _ingredientNormalizer.normalize(i.name) == itemKey,
        );
        var targetUnit = item.unit;
        var targetQty = item.quantity.toDouble();
        if (existingIdx >= 0) {
          final existing = _inventory[existingIdx];
          final existingGroup = existing.unitGroup ?? _unitSystem.groupKey(_unitSystem.groupOf(existing.unit));
          if (existingGroup != unitGroup) {
            throw StateError('unit_group_mismatch');
          }
          targetUnit = existing.unit;
          if (existing.unit.trim().toLowerCase() != item.unit.trim().toLowerCase()) {
            final converted = _unitSystem.convert(item.quantity, fromUnit: item.unit, toUnit: existing.unit);
            if (converted == null) {
              throw StateError('unit_convert_failed');
            }
            targetQty = (existing.quantity + converted).toDouble();
          } else {
            targetQty = (existing.quantity + item.quantity).toDouble();
          }
        }

        final inserted = await DatabaseService.instance.upsertInventoryItem(
          userId: uid,
          itemName: item.name,
          itemKey: itemKey,
          emoji: item.emoji,
          quantity: targetQty,
          unit: targetUnit,
          unitGroup: unitGroup,
        );
        final serverItem = InventoryItem(
          id: inserted['id']?.toString() ?? item.id,
          name: inserted['item_name']?.toString() ?? item.name,
          emoji: inserted['emoji']?.toString() ?? item.emoji,
          quantity: (inserted['quantity'] as num?)?.toInt() ?? targetQty.round(),
          unit: inserted['unit']?.toString() ?? targetUnit,
          itemKey: inserted['item_key']?.toString() ?? itemKey,
          unitGroup: inserted['unit_group']?.toString() ?? unitGroup,
        );
        final existingKeyIdx = _inventory.indexWhere(
          (i) => _ingredientNormalizer.normalize(i.name) == itemKey,
        );
        if (existingKeyIdx >= 0) {
          _inventory[existingKeyIdx] = serverItem;
        } else {
          _inventory.insert(0, serverItem);
        }
        _recomputeRecipeAvailability();
        notifyListeners();
        _persistInventory();
      } catch (_) {
        // If backend fails, keep local item.
        final existingIdx = _inventory.indexWhere(
          (i) => _ingredientNormalizer.normalize(i.name) == itemKey,
        );
        if (existingIdx >= 0) {
          final existing = _inventory[existingIdx];
          final existingGroup = existing.unitGroup ?? _unitSystem.groupKey(_unitSystem.groupOf(existing.unit));
          if (existingGroup != unitGroup) {
            throw StateError('unit_group_mismatch');
          }

          var addedQty = item.quantity.toDouble();
          if (existing.unit.trim().toLowerCase() != item.unit.trim().toLowerCase()) {
            final converted = _unitSystem.convert(item.quantity, fromUnit: item.unit, toUnit: existing.unit);
            if (converted == null) {
              throw StateError('unit_convert_failed');
            }
            addedQty = converted.toDouble();
          }

          _inventory[existingIdx] = existing.copyWith(
            quantity: (existing.quantity + addedQty.round()).clamp(0, 1 << 30),
            // Keep existing.unit stable.
            emoji: item.emoji,
            name: item.name,
            itemKey: itemKey,
            unitGroup: unitGroup,
          );
        } else {
          _inventory.insert(0, item.copyWith(itemKey: itemKey, unitGroup: unitGroup));
        }
        _recomputeRecipeAvailability();
        notifyListeners();
        _persistInventory();
      }
    });
  }

  Future<void> removeItem(String id) async {
    _inventory.removeWhere((i) => i.id == id);
    _recomputeRecipeAvailability();
    notifyListeners();
    _persistInventory();
    final uid = _userId;
    if (uid != null) {
      try {
        await DatabaseService.instance.deleteInventoryItem(id: id, userId: uid);
      } catch (_) {}
    }
  }

  Future<void> updateItem(
    String id, {
    required String name,
    required String emoji,
    required int quantity,
    required String unit,
  }) async {
    final idx = _inventory.indexWhere((i) => i.id == id);
    if (idx < 0) return;

    final safeName = name.trim();
    if (safeName.isEmpty) return;
    final itemKey = _ingredientNormalizer.normalize(safeName);

    final safeQty = quantity < 0 ? 0 : quantity;
    final safeUnit = unit.trim().isEmpty ? _inventory[idx].unit : unit.trim();
    final safeEmoji = emoji.trim().isEmpty ? _inventory[idx].emoji : emoji.trim();
    final unitGroup = _unitSystem.groupKey(_unitSystem.groupOf(safeUnit));

    _inventory[idx] = _inventory[idx].copyWith(
      name: safeName,
      emoji: safeEmoji,
      quantity: safeQty,
      unit: safeUnit,
      itemKey: itemKey,
      unitGroup: unitGroup,
    );
    _recomputeRecipeAvailability();
    notifyListeners();
    _persistInventory();

    final uid = _userId;
    if (uid != null) {
      await _runBusy(() async {
        try {
          final updated = await DatabaseService.instance.updateInventoryItem(
            id: id,
            userId: uid,
            itemName: safeName,
            itemKey: itemKey,
            emoji: safeEmoji,
            quantity: safeQty,
            unit: safeUnit,
            unitGroup: unitGroup,
          );
          _inventory[idx] = InventoryItem(
            id: updated['id']?.toString() ?? id,
            name: updated['item_name']?.toString() ?? safeName,
            emoji: updated['emoji']?.toString() ?? safeEmoji,
            quantity: (updated['quantity'] as num?)?.toInt() ?? safeQty,
            unit: updated['unit']?.toString() ?? safeUnit,
            itemKey: updated['item_key']?.toString() ?? itemKey,
            unitGroup: updated['unit_group']?.toString() ?? unitGroup,
          );
          _recomputeRecipeAvailability();
          notifyListeners();
          _persistInventory();
        } catch (_) {}
      });
    }
  }

  void _recomputeRecipeAvailability() {
    if (_recipes.isEmpty) return;
    final next = _applyInventoryAvailability(_recipes);
    _recipes
      ..clear()
      ..addAll(next);
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
      final ShoppingItem u = updated;
      await _runBusy(() async {
        try {
          await DatabaseService.instance.setShoppingListPurchased(
            itemId: u.id,
            isPurchased: u.isBought,
          );
        } catch (_) {}
      });
    }
  }

  /// Manual entry: always appends (same name can appear with different amounts).
  Future<void> addManualShoppingItem(String listId, ShoppingItem item) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    await _runBusy(() async {
      try {
        final inserted = await DatabaseService.instance.addShoppingListItem(
          listId: listId,
          itemName: item.name,
          amount: item.amount,
          isPurchased: false,
          source: 'manual',
          recipeId: null,
          recipeName: null,
        );
        final serverItem = ShoppingItem(
          id: inserted['id']?.toString() ?? item.id,
          name: inserted['item_name']?.toString() ?? item.name,
          amount: inserted['amount']?.toString() ?? item.amount,
          recipeId: inserted['recipe_id']?.toString() ?? 'manual',
          recipeName: inserted['recipe_name']?.toString(),
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
    });
  }

  Future<void> removeShoppingItem(String listId, String itemId) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = list.items.where((i) => i.id != itemId).toList();
    _shoppingLists[lidx] = list.copyWith(items: next);
    notifyListeners();
    _persistShoppingLists();
    await _runBusy(() async {
      try {
        await DatabaseService.instance.deleteShoppingListItem(itemId: itemId);
      } catch (_) {}
    });
  }

  Future<void> addShoppingItems(String listId, List<ShoppingItem> items) async {
    final lidx = _shoppingLists.indexWhere((l) => l.id == listId);
    if (lidx < 0) return;
    final list = _shoppingLists[lidx];
    final next = List<ShoppingItem>.from(list.items);
    await _runBusy(() async {
      for (final item in items) {
        final itemKey = _ingredientNormalizer.normalize(item.name);
        final exists = next.any((i) {
          final key = _ingredientNormalizer.normalize(i.name);
          return key.isNotEmpty && key == itemKey;
        });
        if (exists) continue;
        try {
          final inserted = await DatabaseService.instance.addShoppingListItem(
            listId: listId,
            itemName: item.name,
            amount: item.amount,
            isPurchased: item.isBought,
            source: 'recipe',
            recipeId: item.recipeId,
            recipeName: item.recipeName,
          );
          next.add(
            ShoppingItem(
              id: inserted['id']?.toString() ?? item.id,
              name: inserted['item_name']?.toString() ?? item.name,
              amount: inserted['amount']?.toString() ?? item.amount,
              recipeId: inserted['recipe_id']?.toString() ?? item.recipeId,
              recipeName: inserted['recipe_name']?.toString() ?? item.recipeName,
              isBought: (inserted['is_purchased'] as bool?) ?? item.isBought,
            ),
          );
        } catch (_) {
          next.add(item);
        }
      }
    });
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

    return _runBusy(() {
      return DatabaseService.instance
          .createShoppingList(userId: uid, name: safeName, description: safeDesc)
          .then((row) {
        final id = row['id']?.toString() ?? 'sl_${DateTime.now().millisecondsSinceEpoch}';
        _shoppingLists.insert(
          0,
          ShoppingListBundle(
            id: id,
            name: row['name']?.toString() ?? safeName,
            description: row['description']?.toString() ?? safeDesc,
          ),
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
      return _runBusy(() async {
        await DatabaseService.instance.updateShoppingListMeta(
          id: id,
          userId: uid,
          name: _shoppingLists[lidx].name,
          description: _shoppingLists[lidx].description,
        );
      });
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
      await _runBusy(() async {
        try {
          await DatabaseService.instance.deleteShoppingList(id: id, userId: uid);
        } catch (_) {}
      });
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
          final merged = _dedupeInventory(_inventory);
          _inventory
            ..clear()
            ..addAll(merged);
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

    final customRaw = prefs.getString(_customRecipesKey);
    if (customRaw != null && customRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(customRaw);
        if (decoded is List) {
          _customRecipes
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

    await _runBusy(() async {
      final sw = Stopwatch()..start();
      var hadAnyError = false;
      try {
        // Fetch in parallel to reduce overall wall time.
        final invF = DatabaseService.instance.fetchInventory(userId: uid);
        final listsF = DatabaseService.instance.fetchShoppingLists(userId: uid);
        final customF = DatabaseService.instance.fetchCustomRecipes(userId: uid);
        final savedF = DatabaseService.instance.fetchSavedRecipes(userId: uid);
        final ratingsF = DatabaseService.instance.fetchRecipeRatings(userId: uid);

        List<Map<String, dynamic>> inv = const [];
        List<Map<String, dynamic>> listRows = const [];
        List<Map<String, dynamic>> customRows = const [];
        List<Map<String, dynamic>> savedRows = const [];
        List<Map<String, dynamic>> ratingRows = const [];

        final results = await Future.wait(<Future<(String, List)>>[
          invF.then<(String, List)>((v) => ('inv', v)).catchError((_) => ('inv_err', const <dynamic>[])),
          listsF.then<(String, List)>((v) => ('lists', v)).catchError((_) => ('lists_err', const <dynamic>[])),
          customF.then<(String, List)>((v) => ('custom', v)).catchError((_) => ('custom_err', const <dynamic>[])),
          savedF.then<(String, List)>((v) => ('saved', v)).catchError((_) => ('saved_err', const <dynamic>[])),
          ratingsF.then<(String, List)>((v) => ('ratings', v)).catchError((_) => ('ratings_err', const <dynamic>[])),
        ]);

        for (final r in results) {
          final tag = r.$1;
          final v = r.$2;
          if (tag == 'inv') inv = v.cast<Map<String, dynamic>>();
          if (tag == 'lists') listRows = v.cast<Map<String, dynamic>>();
          if (tag == 'custom') customRows = v.cast<Map<String, dynamic>>();
          if (tag == 'saved') savedRows = v.cast<Map<String, dynamic>>();
          if (tag == 'ratings') ratingRows = v.cast<Map<String, dynamic>>();
          if (tag.endsWith('_err')) hadAnyError = true;
        }

        // Apply all updates, then persist in parallel (minimizes UI churn).
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
                itemKey: r['item_key']?.toString(),
                unitGroup: r['unit_group']?.toString(),
              ),
            ),
          );
        final mergedInv = _dedupeInventory(_inventory);
        _inventory
          ..clear()
          ..addAll(mergedInv);

        final bundles = <ShoppingListBundle>[];
        for (final l in listRows) {
          final listId = l['id']?.toString() ?? '';
          final embedded = l['shopping_list_items'];
          final itemsRows = (embedded is List) ? embedded.cast<Map>() : const <Map>[];
          final items = itemsRows
              .map((r) => Map<String, dynamic>.from(r))
              .map(
                (r) => ShoppingItem(
                  id: r['id']?.toString() ?? '',
                  name: r['item_name']?.toString() ?? '',
                  amount: r['amount']?.toString() ?? '',
                  recipeId: r['recipe_id']?.toString() ??
                      (r['source']?.toString() == 'manual' ? 'manual' : 'general'),
                  recipeName: r['recipe_name']?.toString(),
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
        final serverIds = bundles.map((b) => b.id).where((s) => s.trim().isNotEmpty).toSet();
        final localOnly = _shoppingLists
            .where((l) => l.id.trim().isNotEmpty && !serverIds.contains(l.id))
            .toList(growable: false);
        _shoppingLists
          ..clear()
          ..addAll(bundles)
          ..addAll(localOnly);
        if (_shoppingLists.isNotEmpty) {
          _preferredShoppingListId ??= _shoppingLists.first.id;
        }

        final parsedCustom = <Recipe>[];
        for (final r in customRows) {
          final id = r['id']?.toString() ?? '';
          final payload = r['recipe'];
          if (id.isEmpty || payload is! Map) continue;
          final json = Map<String, Object?>.from(payload);
          json['id'] = id;
          parsedCustom.add(Recipe.fromJson(json));
        }
        if (parsedCustom.isNotEmpty) {
          _customRecipes
            ..clear()
            ..addAll(parsedCustom);
        }

        _savedRecipeIds
          ..clear()
          ..addAll(
            savedRows.map((r) => r['recipe_id']?.toString() ?? '').where((s) => s.isNotEmpty),
          );

        _recipeRatings
          ..clear()
          ..addEntries(
            ratingRows.map((r) {
              final id = r['recipe_id']?.toString() ?? '';
              final rating = (r['rating'] as num?)?.toInt() ?? 0;
              final comment = r['comment']?.toString() ?? '';
              return MapEntry(id, RecipeUserRating(rating: rating, comment: comment));
            }).where((e) => e.key.isNotEmpty && e.value.rating > 0),
          );

        await Future.wait([
          _persistInventory(),
          _persistShoppingLists(),
          _persistPreferredShoppingListId(),
          _persistCustomRecipes(),
          _persistSavedRecipes(),
          _persistRecipeRatings(),
        ]);
      } finally {
        if (kDebugMode) {
          debugPrint('Backend sync finished in ${sw.elapsedMilliseconds}ms');
        }
        _isSyncingBackend = false;
        _lastBackendSyncError = hadAnyError ? 'Some data could not be loaded from the server.' : null;
        notifyListeners();
      }
    });
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

  Future<void> _persistCustomRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _customRecipes.map((r) => r.toJson()).toList(growable: false),
    );
    await prefs.setString(_customRecipesKey, encoded);
  }
}
