import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/recipe.dart';

/// Loads shared recipes from Supabase with free/premium and filter rules.
class RecipeService {
  RecipeService(this._supabase);

  final SupabaseClient _supabase;

  /// Fetch all recipes (respects premium status and optional filters).
  Future<List<Recipe>> getRecipes({
    required bool isPremiumUser,
    List<String>? dietaryFilters,
    String? searchQuery,
  }) async {
    try {
      dynamic query = _supabase.from('recipes').select();
      if (!isPremiumUser) {
        query = query.eq('is_premium', false);
      }
      final response = await query.order('name', ascending: true);

      List<Recipe> recipes = (response as List)
          .map((r) => Recipe.fromJson(Map<String, Object?>.from(r as Map)))
          .toList();

      if (dietaryFilters != null && dietaryFilters.isNotEmpty) {
        recipes = recipes.where((recipe) {
          final tags = recipe.dietaryTags;
          return dietaryFilters.every(tags.contains);
        }).toList();
      }

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.trim().toLowerCase();
        recipes = recipes
            .where((recipe) => recipe.name.toLowerCase().contains(q))
            .toList();
      }

      if (!isPremiumUser && recipes.length > 10) {
        recipes = recipes.take(10).toList();
      }

      return recipes;
    } catch (e, st) {
      debugPrint('Error fetching recipes: $e\n$st');
      rethrow;
    }
  }

  Future<Recipe?> getRecipeById(String id) async {
    try {
      final response = await _supabase.from('recipes').select().eq('id', id).maybeSingle();
      if (response == null) return null;
      return Recipe.fromJson(Map<String, Object?>.from(response));
    } catch (e, st) {
      debugPrint('Error fetching recipe: $e\n$st');
      rethrow;
    }
  }

  /// Recipes whose [collections] JSON array contains [collection].
  Future<List<Recipe>> getRecipesByCollection(
    String collection, {
    required bool isPremiumUser,
  }) async {
    final all = await getRecipes(isPremiumUser: isPremiumUser);
    return all.where((r) => r.collections.contains(collection)).toList();
  }
}
