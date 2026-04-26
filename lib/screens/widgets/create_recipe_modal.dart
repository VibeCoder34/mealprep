import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../app_state.dart';
import '../../l10n/app_localizations.dart';
import '../../models/recipe.dart';
import '../../models/shopping_item.dart';
import '../../services/ai_service.dart';
import '../recipe_detail_screen.dart';
import '../../widgets/premium_feature_modal.dart';

Future<void> showCreateRecipeModal(
  BuildContext context, {
  required AppState appState,
  String? prefilledTitle,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _CreateRecipeModal(appState: appState, prefilledTitle: prefilledTitle),
  );
}

class _CreateRecipeModal extends StatefulWidget {
  final AppState appState;
  final String? prefilledTitle;
  const _CreateRecipeModal({required this.appState, required this.prefilledTitle});

  @override
  State<_CreateRecipeModal> createState() => _CreateRecipeModalState();
}

class _CreateRecipeModalState extends State<_CreateRecipeModal> {
  late final TextEditingController _addIngredientCtrl;
  late final List<String> _ingredients;
  final Set<String> _dietPrefs = {};

  String? _cookingTime;
  String? _calorieTarget;

  bool _loading = false;
  String? _errorKey;
  Recipe? _generated;

  @override
  void initState() {
    super.initState();
    _addIngredientCtrl = TextEditingController();
    _ingredients = widget.appState.inventory
        .map((i) => i.name.trim())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList();
    _dietPrefs.addAll(widget.appState.dietaryPreferences);
  }

  @override
  void dispose() {
    _addIngredientCtrl.dispose();
    super.dispose();
  }

  AIService _service() {
    return AIService(apiKey: dotenv.env['OPENAI_API_KEY'] ?? '');
  }

  Future<void> _generate() async {
    if (!widget.appState.isPremium) {
      await showPremiumFeatureModal(
        context,
        appState: widget.appState,
        description: AppLocalizations.of(context)!.premiumFeatureDefaultBody,
      );
      return;
    }

    setState(() {
      _loading = true;
      _errorKey = null;
      _generated = null;
    });

    final res = await _service().generateCreativeRecipe(
      ingredients: _ingredients,
      dietaryPreferences: _dietPrefs.toList(growable: false),
      cookingTime: _cookingTime == 'any' ? null : _cookingTime,
      calorieTarget: _calorieTarget == 'any' ? null : _calorieTarget,
    );

    if (!mounted) return;
    if (!res.isOk || res.data == null) {
      setState(() {
        _loading = false;
        _errorKey = _mapAIError(res.error);
      });
      return;
    }

    final recipe = _applyAvailability(res.data!);
    widget.appState.upsertAiDraftRecipe(recipe);
    await _autoAddMissingToShoppingList(recipe);

    setState(() {
      _loading = false;
      _generated = recipe;
    });
  }

  String _normalizeIngredient(String s) {
    var out = s.toLowerCase().trim();
    out = out.replaceAll(RegExp(r'[\(\)\[\]\{\},.;]'), ' ');
    out = out.replaceAll(RegExp(r'\s+'), ' ').trim();
    out = out
        .replaceAll(RegExp(r'\b(ve|ile|bir|az|çok|toz|taze|kuru)\b'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return out;
  }

  bool _ingredientSimilar(String a, String b) {
    if (a.isEmpty || b.isEmpty) return false;
    if (a == b) return true;
    if (a.length >= 4 && b.contains(a)) return true;
    if (b.length >= 4 && a.contains(b)) return true;
    return false;
  }

  Future<void> _autoAddMissingToShoppingList(Recipe recipe) async {
    final listId = widget.appState.defaultTargetListId;
    if (listId == null) return;

    final inventoryNames = widget.appState.inventory
        .map((i) => _normalizeIngredient(i.name))
        .where((s) => s.isNotEmpty)
        .toSet();

    final missing = <RecipeIngredient>[];
    for (final ingredient in recipe.ingredients) {
      final normalized = _normalizeIngredient(ingredient.name);
      if (normalized.isEmpty) continue;
      final inInventory = inventoryNames.any((inv) => _ingredientSimilar(inv, normalized));
      if (!inInventory) missing.add(ingredient);
    }

    if (missing.isEmpty) return;

    final newItems = missing
        .asMap()
        .entries
        .map(
          (e) => ShoppingItem(
            id: 'recipe_${recipe.id}_${e.key}_${DateTime.now().millisecondsSinceEpoch}',
            name: e.value.name,
            amount: e.value.amount,
            recipeId: recipe.id,
          ),
        )
        .toList(growable: false);

    await widget.appState.addShoppingItems(listId, newItems);
  }

  Recipe _applyAvailability(Recipe recipe) {
    final inv = widget.appState.inventory.map((i) => i.name.toLowerCase().trim()).where((s) => s.isNotEmpty).toSet();
    final nextIngredients = recipe.ingredients
        .map(
          (i) => RecipeIngredient(
            name: i.name,
            amount: i.amount,
            unit: i.unit,
            isAvailable: inv.contains(i.name.toLowerCase().trim()),
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

  String _mapAIError(AIError? e) {
    switch (e) {
      case AIError.emptyIngredients:
        return 'ai_empty_ingredients';
      case AIError.network:
        return 'ai_network';
      case AIError.rateLimited:
        return 'ai_rate_limited';
      case AIError.invalidResponse:
        return 'ai_invalid_response';
      case AIError.misconfigured:
        return 'ai_misconfigured';
      case AIError.invalidInput:
        return 'ai_invalid_input';
      case AIError.unknown:
      default:
        return 'ai_unknown';
    }
  }

  String _errorText(AppLocalizations l10n, String key) {
    switch (key) {
      case 'ai_empty_ingredients':
        return l10n.aiEmptyIngredients;
      case 'ai_network':
        return l10n.aiConnectionError;
      case 'ai_rate_limited':
        return l10n.aiRateLimited;
      case 'ai_invalid_response':
        return l10n.aiInvalidResponse;
      case 'ai_misconfigured':
        return l10n.aiMisconfigured;
      default:
        return l10n.aiUnknownError;
    }
  }

  Future<void> _openDetail() async {
    final r = _generated;
    if (r == null) return;
    if (!mounted) return;
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(recipeId: r.id, appState: widget.appState),
      ),
    );
  }

  Future<void> _addMissingToShopping() async {
    final recipe = _generated;
    if (recipe == null) return;
    final missing = recipe.ingredients.where((i) => !i.isAvailable).toList();
    if (missing.isEmpty) return;

    final listId = widget.appState.defaultTargetListId;
    if (listId == null) return;
    final newItems = missing
        .asMap()
        .entries
        .map(
          (e) => ShoppingItem(
            id: 'recipe_${recipe.id}_${e.key}_${DateTime.now().millisecondsSinceEpoch}',
            name: e.value.name,
            amount: e.value.amount,
            recipeId: recipe.id,
          ),
        )
        .toList(growable: false);
    await widget.appState.addShoppingItems(listId, newItems);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.aiAddedToShopping),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addIngredientFromInput() {
    final v = _addIngredientCtrl.text.trim();
    if (v.isEmpty) return;
    setState(() {
      _ingredients.add(v);
      _addIngredientCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  l10n.aiCreateTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 14),

                Text(
                  l10n.aiCreateIngredientsLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final ing in _ingredients)
                      InputChip(
                        label: Text(ing),
                        onDeleted: () => setState(() => _ingredients.remove(ing)),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _addIngredientCtrl,
                        onSubmitted: (_) => _addIngredientFromInput(),
                        decoration: InputDecoration(
                          hintText: l10n.aiCreateIngredientHint,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: _addIngredientFromInput,
                      child: Text(l10n.addItem),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Text(
                  l10n.aiDietaryPreference,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                _check('vegan', l10n.dietVegan),
                _check('vegetarian', l10n.dietVegetarian),
                _check('keto', l10n.dietKeto),
                _check('gluten_free', l10n.dietGlutenFree),
                _check('halal', l10n.dietHalal),
                _check('no_dairy', l10n.dietNoDairy),

                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _dropdown(
                        label: l10n.aiCookingTime,
                        value: _cookingTime,
                        items: const [
                          ('any', 'Fark Etmiyor'),
                          ('5', '5 dk'),
                          ('15', '15 dk'),
                          ('30', '30 dk'),
                          ('60', '60 dk'),
                        ],
                        onChanged: (v) => setState(() => _cookingTime = v),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _dropdown(
                        label: l10n.aiCalorieTarget,
                        value: _calorieTarget,
                        items: const [
                          ('any', 'Fark Etmiyor'),
                          ('low', 'Low (< 300 cal)'),
                          ('medium', 'Medium (300-600)'),
                          ('high', 'High (600+)'),
                        ],
                        onChanged: (v) => setState(() => _calorieTarget = v),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                if (_errorKey != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.errorContainer.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cs.errorContainer),
                    ),
                    child: Text(
                      _errorText(l10n, _errorKey!),
                      style: TextStyle(color: cs.error),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _generate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: _loading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Text(l10n.aiGenerating),
                            ],
                          )
                        : Text(
                            l10n.aiGenerateRecipe,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                  ),
                ),

                if (_generated != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF0F0F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.aiRecipeCreated,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_generated!.emoji} ${_generated!.name}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _openDetail,
                                child: Text(l10n.aiOpenRecipe),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: FilledButton(
                                onPressed: _addMissingToShopping,
                                child: Text(l10n.aiAddMissingToShopping),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _check(String key, String label) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      value: _dietPrefs.contains(key),
      onChanged: (v) {
        setState(() {
          if (v == true) {
            _dietPrefs.add(key);
          } else {
            _dietPrefs.remove(key);
          }
        });
      },
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<(String, String)> items,
    required void Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value ?? 'any',
          isExpanded: true,
          items: [
            for (final it in items)
              DropdownMenuItem(
                value: it.$1,
                child: Text(it.$2),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

