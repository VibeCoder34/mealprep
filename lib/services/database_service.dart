import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  SupabaseClient get _client => Supabase.instance.client;

  // Recipes (shared)
  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final res = await _client.from('recipes').select().order('created_at');
    return (res as List).cast<Map<String, dynamic>>();
  }

  // Inventory (per user)
  Future<List<Map<String, dynamic>>> fetchInventory({required String userId}) async {
    final res = await _client
        .from('inventory')
        .select()
        .eq('user_id', userId)
        .order('added_at', ascending: false);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> addInventoryItem({
    required String userId,
    required String itemName,
    required String itemKey,
    required String emoji,
    required num quantity,
    required String unit,
    required String unitGroup,
  }) async {
    final res = await _client
        .from('inventory')
        .insert({
          'user_id': userId,
          'item_name': itemName,
          'item_key': itemKey,
          'emoji': emoji,
          'quantity': quantity,
          'unit': unit,
          'unit_group': unitGroup,
        })
        .select()
        .single();
    return (res as Map).cast<String, dynamic>();
  }

  /// Upserts an inventory row by `(user_id, item_key, unit_group)`.
  Future<Map<String, dynamic>> upsertInventoryItem({
    required String userId,
    required String itemName,
    required String itemKey,
    required String emoji,
    required num quantity,
    required String unit,
    required String unitGroup,
  }) async {
    final res = await _client
        .from('inventory')
        .upsert(
          {
            'user_id': userId,
            'item_name': itemName,
            'item_key': itemKey,
            'emoji': emoji,
            'quantity': quantity,
            'unit': unit,
            'unit_group': unitGroup,
            'updated_at': DateTime.now().toIso8601String(),
          },
          onConflict: 'user_id,item_key,unit_group',
        )
        .select()
        .single();
    return (res as Map).cast<String, dynamic>();
  }

  Future<void> deleteInventoryItem({
    required String id,
    required String userId,
  }) async {
    await _client.from('inventory').delete().eq('id', id).eq('user_id', userId);
  }

  Future<Map<String, dynamic>> updateInventoryItem({
    required String id,
    required String userId,
    required String itemName,
    required String itemKey,
    required String emoji,
    required num quantity,
    required String unit,
    required String unitGroup,
  }) async {
    final res = await _client
        .from('inventory')
        .update({
          'item_name': itemName,
          'item_key': itemKey,
          'emoji': emoji,
          'quantity': quantity,
          'unit': unit,
          'unit_group': unitGroup,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id)
        .eq('user_id', userId)
        .select()
        .single();
    return (res as Map).cast<String, dynamic>();
  }

  // Shopping lists (per user)
  Future<List<Map<String, dynamic>>> fetchShoppingLists({required String userId}) async {
    // Fetch lists WITH items in one roundtrip (avoids N+1 requests).
    // Requires FK relationship: shopping_list_items.list_id -> shopping_lists.id
    final res = await _client
        .from('shopping_lists')
        .select(
          'id,name,description,created_at,updated_at,shopping_list_items(id,item_name,amount,is_purchased,source,recipe_id,recipe_name,created_at,updated_at)',
        )
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchShoppingListItems({required String listId}) async {
    final res = await _client
        .from('shopping_list_items')
        .select()
        .eq('list_id', listId)
        .order('created_at', ascending: false);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> createShoppingList({
    required String userId,
    required String name,
    required String description,
  }) async {
    final res = await _client
        .from('shopping_lists')
        .insert({
          'user_id': userId,
          'name': name,
          'description': description,
        })
        .select()
        .single();
    return (res as Map).cast<String, dynamic>();
  }

  Future<void> updateShoppingListMeta({
    required String id,
    required String userId,
    required String name,
    required String description,
  }) async {
    await _client
        .from('shopping_lists')
        .update({
          'name': name,
          'description': description,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id)
        .eq('user_id', userId);
  }

  Future<void> deleteShoppingList({
    required String id,
    required String userId,
  }) async {
    await _client.from('shopping_lists').delete().eq('id', id).eq('user_id', userId);
  }

  Future<Map<String, dynamic>> addShoppingListItem({
    required String listId,
    required String itemName,
    required String amount,
    required bool isPurchased,
    required String source,
    String? recipeId,
    String? recipeName,
  }) async {
    final res = await _client
        .from('shopping_list_items')
        .insert({
          'list_id': listId,
          'item_name': itemName,
          'amount': amount,
          'is_purchased': isPurchased,
          'source': source,
          'recipe_id': recipeId,
          if (recipeName != null) 'recipe_name': recipeName,
        })
        .select()
        .single();
    return (res as Map).cast<String, dynamic>();
  }

  Future<void> setShoppingListPurchased({
    required String itemId,
    required bool isPurchased,
  }) async {
    await _client.from('shopping_list_items').update({
      'is_purchased': isPurchased,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', itemId);
  }

  Future<void> deleteShoppingListItem({required String itemId}) async {
    await _client.from('shopping_list_items').delete().eq('id', itemId);
  }

  // Saved recipes (per user)
  Future<List<Map<String, dynamic>>> fetchSavedRecipes({required String userId}) async {
    final res = await _client
        .from('saved_recipes')
        .select('recipe_id')
        .eq('user_id', userId);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<void> saveRecipe({required String userId, required String recipeId}) async {
    await _client.from('saved_recipes').insert({
      'user_id': userId,
      'recipe_id': recipeId,
    });
  }

  Future<void> unsaveRecipe({required String userId, required String recipeId}) async {
    await _client.from('saved_recipes').delete().eq('user_id', userId).eq('recipe_id', recipeId);
  }

  // Recipe ratings (per user)
  Future<List<Map<String, dynamic>>> fetchRecipeRatings({required String userId}) async {
    final res = await _client
        .from('recipe_ratings')
        .select('recipe_id,rating,comment')
        .eq('user_id', userId);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<void> upsertRecipeRating({
    required String userId,
    required String recipeId,
    required int rating,
    required String comment,
  }) async {
    await _client.from('recipe_ratings').upsert({
      'user_id': userId,
      'recipe_id': recipeId,
      'rating': rating,
      'comment': comment,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteRecipeRating({required String userId, required String recipeId}) async {
    await _client.from('recipe_ratings').delete().eq('user_id', userId).eq('recipe_id', recipeId);
  }

  // Custom recipes (per user; includes AI-generated)
  Future<List<Map<String, dynamic>>> fetchCustomRecipes({required String userId}) async {
    final res = await _client
        .from('custom_recipes')
        .select('id,recipe,updated_at')
        .eq('user_id', userId)
        .order('updated_at', ascending: false);
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<void> upsertCustomRecipe({
    required String userId,
    required String id,
    required Map<String, Object?> recipeJson,
  }) async {
    await _client.from('custom_recipes').upsert({
      'id': id,
      'user_id': userId,
      'recipe': recipeJson,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteCustomRecipe({
    required String userId,
    required String id,
  }) async {
    await _client.from('custom_recipes').delete().eq('user_id', userId).eq('id', id);
  }
}

