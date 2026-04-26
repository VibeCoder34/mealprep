import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/recipe.dart';
import '../models/shopping_item.dart';
import '../models/recipe_user_rating.dart';
import '../app_state.dart';
import '../widgets/premium_feature_modal.dart';
import '../services/ingredient_normalizer.dart';
import '../services/shopping_ingredient_formatter.dart';
import 'cooking_steps_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;
  final AppState appState;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    required this.appState,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Recipe? _recipe;
  bool _loading = true;
  bool _loadFailed = false;
  final IngredientNormalizer _normalizer = const IngredientNormalizer();
  final ShoppingIngredientFormatter _shoppingFmt = const ShoppingIngredientFormatter();

  @override
  void initState() {
    super.initState();
    _primeOrLoad();
  }

  Future<void> _primeOrLoad() async {
    for (final r in widget.appState.recipes) {
      if (r.id == widget.recipeId) {
        if (mounted) {
          setState(() {
            _recipe = r;
            _loading = false;
          });
        }
        return;
      }
    }
    await _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      final r = await widget.appState.fetchRecipeById(widget.recipeId);
      if (!mounted) return;
      setState(() {
        _recipe = r;
        _loadFailed = r == null;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _recipe = null;
        _loadFailed = true;
        _loading = false;
      });
    }
  }

  void _openRatingSheet(BuildContext context, AppLocalizations l10n) {
    final recipe = _recipe!;
    final existing = widget.appState.ratingForRecipe(recipe.id);
    var selected = existing?.rating ?? 0;
    final ctrl = TextEditingController(text: existing?.comment ?? '');

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Widget star(int i) {
              final filled = i <= selected;
              return IconButton(
                onPressed: () => setModalState(() => selected = i),
                icon: Icon(
                  filled ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: filled ? const Color(0xFFFFC107) : const Color(0xFFBDBDBD),
                  size: 32,
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.viewInsetsOf(ctx).bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    l10n.rateRecipeTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [for (var i = 1; i <= 5; i++) star(i)],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ctrl,
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: l10n.addCommentLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      if (existing != null) ...[
                        TextButton(
                          onPressed: () async {
                            await widget.appState.removeRecipeRating(recipe.id);
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFE53935),
                          ),
                          child: Text(l10n.ratingDelete),
                        ),
                        const Spacer(),
                      ] else
                        const Spacer(),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(l10n.cancel),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: selected == 0
                            ? null
                            : () async {
                                await widget.appState.setRecipeRating(
                                  recipe.id,
                                  rating: selected,
                                  comment: ctrl.text,
                                );
                                if (ctx.mounted) Navigator.pop(ctx);
                              },
                        child: Text(l10n.ratingSave),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(ctrl.dispose);
  }

  Future<void> _selectRecipe(BuildContext context) async {
    final recipe = _recipe!;
    final missing = recipe.ingredients.where((i) => !i.isAvailable).toList();

    if (missing.isEmpty) {
      _openCookingSteps();
      return;
    }

    List<ShoppingItem> buildItems({required bool includeSpices}) {
      return missing
        .asMap()
        .entries
        .map((e) {
          final shoppingName = _shoppingFmt.toShoppingName(
            e.value.name,
            includePantryOrSpice: includeSpices,
          );
          if (shoppingName == null) return null;
          return ShoppingItem(
            id: 'recipe_${recipe.id}_${e.key}_${DateTime.now().millisecondsSinceEpoch}',
            name: shoppingName,
            // Shopping list is a checklist; purchase quantity is decided at "bought" time.
            amount: '',
            recipeId: recipe.id,
            recipeName: recipe.name,
          );
        })
        .whereType<ShoppingItem>()
        .toList(growable: false);
    }

    final itemsWithoutSpices = buildItems(includeSpices: false);
    final itemsWithSpices = buildItems(includeSpices: true);

    final lists = widget.appState.shoppingLists;
    if (lists.isEmpty) {
      // Shouldn't happen (app normally keeps at least one list), but fail safe:
      // add to a best-effort default and show confirmation.
      final fallbackId = widget.appState.defaultTargetListId ?? 'default';
      await widget.appState.addShoppingItems(fallbackId, itemsWithoutSpices);
      if (!context.mounted) return;
      _openCookingSteps();
      return;
    }

    // Always allow the user to choose the target list (even if there's only one).
    _showPickShoppingListSheet(
      context,
      itemsWithoutSpices: itemsWithoutSpices,
      itemsWithSpices: itemsWithSpices,
    );
  }

  void _openCookingSteps() {
    final r = _recipe;
    if (r == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CookingStepsScreen(
          recipeId: r.id,
          appState: widget.appState,
        ),
      ),
    );
  }

  void _showPickShoppingListSheet(
    BuildContext context,
    {required List<ShoppingItem> itemsWithoutSpices,
    required List<ShoppingItem> itemsWithSpices}
  ) {
    final l10n = AppLocalizations.of(context)!;
    var selectedId = widget.appState.defaultTargetListId ?? widget.appState.shoppingLists.first.id;
    var includeSpices = false;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> createNewListAndAdd() async {
              var createdId = '';

              final res = await showDialog<_NewListResult?>(
                context: ctx,
                builder: (dctx) => _CreateShoppingListDialog(
                  cancelLabel: l10n.cancel,
                  title: 'Yeni liste oluştur',
                  createLabel: 'Oluştur',
                ),
              );

              if (res == null) return; // cancelled
              final name = res.name.trim();
              if (name.isEmpty) return;

              createdId = await widget.appState.createShoppingList(
                name: name,
                description: res.description.trim(),
              );

              if (createdId.isEmpty) return;

              final chosen = includeSpices ? itemsWithSpices : itemsWithoutSpices;
              widget.appState.setPreferredShoppingList(createdId);
              await widget.appState.addShoppingItems(createdId, chosen);
              if (!mounted) return;
              if (ctx.mounted) Navigator.of(ctx).pop(); // close picker sheet
              await Future<void>.delayed(Duration.zero);
              _openCookingSteps();
            }

            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxH = constraints.maxHeight;
                  // Keep a consistent sheet height; allow internal scrolling for long content.
                  final sheetH = (maxH * 0.78).clamp(320.0, maxH);
                  return SizedBox(
                    height: sheetH,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              l10n.chooseListForRecipe,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: CheckboxListTile(
                              value: includeSpices,
                              onChanged: (v) => setModalState(() => includeSpices = v ?? false),
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text('Baharatları da ekle'),
                              subtitle: const Text(
                                'Tuz/karabiber/kimyon gibi temel baharatlar da listeye eklensin.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                            child: OutlinedButton.icon(
                              onPressed: createNewListAndAdd,
                              icon: const Icon(Icons.add_rounded, size: 18),
                              label: const Text('Yeni liste oluştur'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              itemCount: widget.appState.shoppingLists.length,
                              itemBuilder: (context, i) {
                                final list = widget.appState.shoppingLists[i];
                                return RadioListTile<String>(
                                  title: Text(
                                    list.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: list.description.trim().isEmpty
                                      ? null
                                      : Text(
                                          list.description.trim(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  value: list.id,
                                  groupValue: selectedId,
                                  activeColor: const Color(0xFF00ACC1),
                                  onChanged: (v) {
                                    if (v == null) return;
                                    setModalState(() => selectedId = v);
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                final chosen = includeSpices ? itemsWithSpices : itemsWithoutSpices;
                                widget.appState.setPreferredShoppingList(selectedId);
                                widget.appState.addShoppingItems(selectedId, chosen);
                                Navigator.of(ctx).pop();
                                Future<void>.delayed(Duration.zero).then((_) => _openCookingSteps());
                              },
                              child: Text(l10n.confirmAddToList),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loading && _recipe == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 1,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
                color: const Color(0xFF1A1A2E),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Container(
                width: 180,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFF0F0F0)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F7FA),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: const Color(0xFFF0F0F0)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F0F0),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (var i = 0; i < 3; i++)
                                      Container(
                                        width: 86,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F7FA),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: const Color(0xFFF0F0F0)),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFF0F0F0)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    if ((_loadFailed || _recipe == null) && !_loading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
            color: const Color(0xFF1A1A2E),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(l10n.recipeSuggestions),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.recipesLoadFailed,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _fetch,
                  child: Text(l10n.retryLoad),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final recipe = _recipe!;
    final missingCount = recipe.missingCount;
    final title = recipe.name;
    final category = l10n.categoryLabel(recipe.category);
    final time = l10n.prepTimeMin(recipe.prepTimeMinutes);
    final difficulty = l10n.difficultyLabel(recipe.difficulty);
    final imageUrl = recipe.imageUrl;

    final RecipeUserRating? myRating = widget.appState.ratingForRecipe(recipe.id);
    final match = _computeMatch(recipe);

    if (recipe.isPremium && !widget.appState.isPremium) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
            color: const Color(0xFF1A1A2E),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('👑', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 16),
                Text(
                  l10n.premiumFeatureTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.premiumFeatureDefaultBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF9E9E9E),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showPremiumFeatureModal(
                      context,
                      appState: widget.appState,
                      description: l10n.premiumFeatureDefaultBody,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(l10n.upgradeToPremiumCta),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 1,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
              color: const Color(0xFF1A1A2E),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.3,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  final ok = await widget.appState.toggleSavedRecipe(recipe.id);
                  if (!ok && context.mounted) {
                    await showPremiumSavedLimitModal(context);
                  }
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    widget.appState.isRecipeSaved(recipe.id)
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey(widget.appState.isRecipeSaved(recipe.id)),
                    color: widget.appState.isRecipeSaved(recipe.id)
                        ? const Color(0xFFE53935)
                        : const Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F7FA),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: const Color(0xFFF0F0F0)),
                            ),
                            child: (imageUrl != null && imageUrl.trim().isNotEmpty)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Text(recipe.emoji, style: const TextStyle(fontSize: 40)),
                                      ),
                                      loadingBuilder: (context, child, progress) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(recipe.emoji, style: const TextStyle(fontSize: 40)),
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A2E),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F7FA),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: const Color(0xFFF0F0F0)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.inventory_2_rounded, size: 16, color: Color(0xFF00ACC1)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          match.missingNames.isEmpty
                                              ? '${match.matchPercent}% · ${l10n.matchPerfectShort}'
                                              : '${match.matchPercent}% · ${l10n.matchNeedPrefix} ${match.missingNames.join(', ')}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF424242),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _MetaChip(icon: Icons.schedule_rounded, label: time),
                                    _MetaChip(icon: Icons.restaurant_rounded, label: category),
                                    _MetaChip(icon: Icons.trending_up_rounded, label: difficulty),
                                    _MetaChip(icon: Icons.people_alt_rounded, label: '${recipe.servings}×'),
                                  ],
                                ),
                                if (recipe.collections.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: recipe.collections
                                        .take(3)
                                        .map(
                                          (c) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE0F7FA),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              border: Border.all(
                                                color: const Color(0xFFB2EBF2),
                                              ),
                                            ),
                                            child: Text(
                                              c,
                                              style: const TextStyle(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF006064),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                                if (recipe.dietaryTags.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: recipe.dietaryTags
                                        .take(4)
                                        .map(
                                          (t) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF3E5F5),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              border: Border.all(
                                                color: const Color(0xFFE1BEE7),
                                              ),
                                            ),
                                            child: Text(
                                              t,
                                              style: const TextStyle(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF4A148C),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (missingCount > 0) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: const Color(0xFFFFCC80)),
                          ),
                          child: Row(
                            children: [
                              const Text('⚠️',
                                  style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.missingIngredientsBanner(missingCount),
                                  style: const TextStyle(
                                    color: Color(0xFFE65100),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: const Color(0xFFA5D6A7)),
                          ),
                          child: Row(
                            children: [
                              const Text('✅', style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.allIngredientsAvailable,
                                  style: const TextStyle(
                                    color: Color(0xFF2E7D32),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFF0F0F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.rateRecipeTitle,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _openRatingSheet(context, l10n),
                            child: Text(l10n.rateRecipeTitle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          for (var i = 1; i <= 5; i++)
                            Icon(
                              (myRating?.rating ?? 0) >= i
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: (myRating?.rating ?? 0) >= i
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFFBDBDBD),
                              size: 20,
                            ),
                          const Spacer(),
                          if (myRating != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFFFECB3),
                                ),
                              ),
                              child: Text(
                                '${myRating.rating}/5',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8D6E63),
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                      if ((myRating?.comment ?? '').trim().isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          '“${myRating!.comment.trim()}”',
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF757575),
                            height: 1.35,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        l10n.nutritionEstimated,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _NutritionCell(
                            label: l10n.calories,
                            value: '${recipe.nutrition.calories}',
                            unit: l10n.kcal,
                            color: const Color(0xFFFF7043),
                          ),
                          _NutritionCell(
                            label: l10n.protein,
                            value: '${recipe.nutrition.protein}',
                            unit: l10n.unitG,
                            color: const Color(0xFF42A5F5),
                          ),
                          _NutritionCell(
                            label: l10n.carbs,
                            value: '${recipe.nutrition.carbs}',
                            unit: l10n.unitG,
                            color: const Color(0xFFFFCA28),
                          ),
                          _NutritionCell(
                            label: l10n.fat,
                            value: '${recipe.nutrition.fat}',
                            unit: l10n.unitG,
                            color: const Color(0xFF66BB6A),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _SectionTitle(l10n.ingredientsSection),
                          const SizedBox(width: 8),
                          if (missingCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3E0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                l10n.missingCountShort(missingCount),
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFFE65100),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _Legend(
                              color: const Color(0xFF66BB6A),
                              label: l10n.legendHave),
                          const SizedBox(width: 16),
                          _Legend(
                              color: const Color(0xFFFF7043),
                              label: l10n.legendMissing),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFF0F0F0)),
                        ),
                        child: Column(
                          children: recipe.ingredients
                              .asMap()
                              .entries
                              .map((e) => _IngredientRow(
                                    ingredient: e.value,
                                    isLast: e.key ==
                                        recipe.ingredients.length - 1,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(l10n.instructionsSection),
                      const SizedBox(height: 12),
                      ...List.generate(
                        recipe.steps.length,
                        (i) => _StepRow(
                          number: i + 1,
                          text: recipe.steps[i],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _selectRecipe(context),
                  icon: Icon(
                    missingCount > 0
                        ? Icons.shopping_cart_outlined
                        : Icons.check_circle_outline_rounded,
                    size: 20,
                  ),
                  label: Text(
                    missingCount > 0
                        ? l10n.selectRecipeWithMissing(missingCount)
                        : l10n.selectRecipe,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MatchSummary _computeMatch(Recipe recipe) {
    final inv = widget.appState.inventory
        .map((i) => _normalizer.normalize(i.name))
        .where((s) => s.isNotEmpty)
        .toSet();

    final normalizedRecipe = recipe.ingredients
        .map((i) => _normalizer.normalize(i.name))
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    final total = normalizedRecipe.length;
    var matched = 0;
    final missing = <String>[];

    for (final ing in recipe.ingredients) {
      final key = _normalizer.normalize(ing.name);
      if (key.isEmpty) continue;
      if (inv.contains(key)) {
        matched += 1;
      } else {
        missing.add(ing.name);
      }
    }

    final pct = total == 0 ? 0 : ((matched / total) * 100).round();
    return _MatchSummary(matchPercent: pct, missingNames: missing.take(3).toList(growable: false));
  }
}

class _NewListResult {
  final String name;
  final String description;
  const _NewListResult({required this.name, required this.description});
}

class _CreateShoppingListDialog extends StatefulWidget {
  final String title;
  final String cancelLabel;
  final String createLabel;
  const _CreateShoppingListDialog({
    required this.title,
    required this.cancelLabel,
    required this.createLabel,
  });

  @override
  State<_CreateShoppingListDialog> createState() => _CreateShoppingListDialogState();
}

class _CreateShoppingListDialogState extends State<_CreateShoppingListDialog> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameCtrl,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Liste adı',
                  hintText: 'Örn: Haftalık Alışveriş',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descCtrl,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Açıklama (opsiyonel)',
                  hintText: 'Örn: Pazartesi market',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(widget.cancelLabel),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameCtrl.text.trim();
            if (name.isEmpty) return;
            Navigator.of(context).pop(
              _NewListResult(name: name, description: _descCtrl.text),
            );
          },
          child: Text(widget.createLabel),
        ),
      ],
    );
  }
}

class _MatchSummary {
  final int matchPercent;
  final List<String> missingNames;
  const _MatchSummary({required this.matchPercent, required this.missingNames});
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF9E9E9E)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionCell extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _NutritionCell({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFFBDBDBD)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A2E),
        letterSpacing: -0.3,
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final RecipeIngredient ingredient;
  final bool isLast;

  const _IngredientRow({required this.ingredient, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = l10n.ingredientLabel(ingredient.name);
    final amt = l10n.formatIngredientAmount(ingredient.amount);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ingredient.isAvailable
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFBE9E7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  ingredient.isAvailable
                      ? Icons.check_rounded
                      : Icons.close_rounded,
                  size: 16,
                  color: ingredient.isAvailable
                      ? const Color(0xFF66BB6A)
                      : const Color(0xFFFF7043),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ingredient.isAvailable
                        ? const Color(0xFF1A1A2E)
                        : const Color(0xFF757575),
                  ),
                ),
              ),
              Text(
                amt,
                style: TextStyle(
                  fontSize: 13.5,
                  color: ingredient.isAvailable
                      ? const Color(0xFF757575)
                      : const Color(0xFFBDBDBD),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
              height: 1,
              indent: 56,
              endIndent: 16,
              color: Color(0xFFF5F5F5)),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;

  const _StepRow({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00ACC1),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF424242),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
