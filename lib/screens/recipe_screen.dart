import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/recipe.dart';
import '../models/recipe_filter.dart';
import '../services/recipe_discovery_service.dart';
import '../widgets/premium_feature_modal.dart';
import 'add_inventory_screen.dart';
import 'recipe_detail_screen.dart';
import 'widgets/advanced_recipe_filter_modal.dart';
import 'widgets/weekly_meal_plan_modal.dart';

class RecipeScreen extends StatefulWidget {
  final AppState appState;

  const RecipeScreen({super.key, required this.appState});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  RecipeFilter _filter = RecipeFilter.empty;
  RecipeSortOption _sort = RecipeSortOption.bestMatch;

  static const _mealTypes = <(String, String)>[
    ('breakfast', '🍳'),
    ('lunch', '🥗'),
    ('dinner', '🍲'),
    ('snack', '🥪'),
  ];

  static const _quickDietaryTags = <String>[
    'vegan',
    'keto',
    'gluten_free',
    'high_protein',
    'low_carb',
  ];

  final RecipeDiscoveryService _discovery = RecipeDiscoveryService();

  String _emptyRecipeMessage(
    AppLocalizations l10n,
    AppState appState,
  ) {
    if (appState.recipes.isEmpty) {
      if (appState.dietaryPreferences.isNotEmpty) {
        return l10n.recipesNoDietMatch;
      }
      return l10n.recipesEmpty;
    }
    return l10n.noRecipesInCategory;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          l10n.recipeSuggestions,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
        ),
        actions: [
          IconButton(
            tooltip: l10n.featWeeklyMealPlan,
            onPressed: widget.appState.isPremium
                ? () => showWeeklyMealPlanModal(context, appState: widget.appState)
                : () => showPremiumFeatureModal(
                      context,
                      appState: widget.appState,
                      description: l10n.premiumFeatureDefaultBody,
                    ),
            icon: const Icon(Icons.calendar_month_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: ListenableBuilder(
        listenable: widget.appState,
        builder: (context, _) {
          // Discovery-first direction: no AI "generate" entry point here.
          return const SizedBox.shrink();
        },
      ),
      body: ListenableBuilder(
        listenable: widget.appState,
        builder: (context, _) {
          final inventoryCount = widget.appState.inventory.length;
          if (inventoryCount == 0) return _buildNoInventoryState(context);
          return _buildRecipeList(context, inventoryCount);
        },
      ),
    );
  }

  Widget _buildNoInventoryState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Text('🥕', style: TextStyle(fontSize: 52)),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.noPantryItems,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.noPantryItemsSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5,
                color: cs.onSurfaceVariant,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        AddInventoryScreen(appState: widget.appState),
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(l10n.addItemsButton),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(BuildContext context, int inventoryCount) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    if (widget.appState.recipesLoading && widget.appState.recipes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                l10n.recipesLoading,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.appState.recipesLoadError != null &&
        widget.appState.recipes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded,
                  size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              Text(
                l10n.recipesLoadFailed,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF757575),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => widget.appState.loadRecipes(),
                child: Text(l10n.retryLoad),
              ),
            ],
          ),
        ),
      );
    }

    final results = _discovery.discover(
      recipes: widget.appState.recipes,
      inventory: widget.appState.inventory,
      filter: _filter.copyWith(
        // Merge profile dietary preferences into filter (AND)
        dietaryTags: {..._filter.dietaryTags, ...widget.appState.dietaryPreferences},
      ),
      sort: _sort,
    ).take(20).toList(growable: false);

    final savedIds = widget.appState.savedRecipeIds;
    final savedRecipes = savedIds
        .map((id) {
          for (final r in widget.appState.recipes) {
            if (r.id == id) return r;
          }
          return null;
        })
        .whereType<Recipe>()
        .toList(growable: false);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Text('✨', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.withPantryItemsCount(inventoryCount),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.recipesFoundCount(results.length),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<RecipeSortOption>(
                  tooltip: l10n.sortTooltip,
                  icon: const Icon(Icons.sort_rounded, color: Colors.white),
                  onSelected: (v) => setState(() => _sort = v),
                  itemBuilder: (ctx) => [
                    PopupMenuItem(value: RecipeSortOption.bestMatch, child: Text(l10n.sortBestMatch)),
                    PopupMenuItem(value: RecipeSortOption.newest, child: Text(l10n.sortNewest)),
                    PopupMenuItem(value: RecipeSortOption.popular, child: Text(l10n.sortPopular)),
                    PopupMenuItem(value: RecipeSortOption.rating, child: Text(l10n.sortRating)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 1 + _mealTypes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                if (index == 0) {
                  final isSelected = _filter.mealType == null;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = _filter.copyWith(clearMealType: true)),
                    child: _Chip(
                      label: l10n.categoryAll,
                      isSelected: isSelected,
                    ),
                  );
                }
                final mt = _mealTypes[index - 1].$1;
                final emoji = _mealTypes[index - 1].$2;
                final isSelected = _filter.mealType == mt;
                final label = '$emoji ${l10n.categoryLabel(mt)}';
                return GestureDetector(
                  onTap: () => setState(() => _filter = _filter.copyWith(mealType: mt)),
                  child: _Chip(label: label, isSelected: isSelected),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _quickDietaryTags.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                if (index == _quickDietaryTags.length) {
                  return OutlinedButton.icon(
                    onPressed: () async {
                      final next = await showAdvancedRecipeFilterModal(context, current: _filter);
                      if (next == null) return;
                      setState(() => _filter = next);
                    },
                    icon: const Icon(Icons.tune_rounded, size: 18),
                    label: Text(l10n.advancedFiltersTitle),
                  );
                }
                final key = _quickDietaryTags[index];
                final selected = _filter.dietaryTags.contains(key);
                final label = l10n.dietLabelForKey(key);
                return GestureDetector(
                  onTap: () {
                    final nextTags = Set<String>.from(_filter.dietaryTags);
                    selected ? nextTags.remove(key) : nextTags.add(key);
                    setState(() => _filter = _filter.copyWith(dietaryTags: nextTags));
                  },
                  child: _Chip(label: label, isSelected: selected),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        if (savedRecipes.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(
                children: [
                  const Text('💛', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    l10n.savedRecipesTitle,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final recipe = savedRecipes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RecipeCard(
                      recipe: recipe,
                      appState: widget.appState,
                      onOpenDetail: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(
                            recipeId: recipe.id,
                            appState: widget.appState,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: savedRecipes.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
        if (results.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🍽️', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text(
                    _emptyRecipeMessage(l10n, widget.appState),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = results[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RecipeCard(
                      recipe: item.recipe,
                      appState: widget.appState,
                      matchPercent: item.matchPercent,
                      missingCountOverride: item.missingCount,
                      totalCountOverride: item.totalCount,
                      onOpenDetail: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(
                            recipeId: item.recipe.id,
                            appState: widget.appState,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: results.length,
              ),
            ),
          ),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final AppState appState;
  final VoidCallback onOpenDetail;
  final int? matchPercent;
  final int? missingCountOverride;
  final int? totalCountOverride;

  const _RecipeCard({
    required this.recipe,
    required this.appState,
    required this.onOpenDetail,
    this.matchPercent,
    this.missingCountOverride,
    this.totalCountOverride,
  });

  bool get _lockedPremium => recipe.isPremium && !appState.isPremium;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalCount = totalCountOverride ?? recipe.ingredients.length;
    final missingCount = missingCountOverride ?? recipe.missingCount;
    final availableCount = (totalCount - missingCount).clamp(0, totalCount);
    final title = recipe.name;
    final cat = l10n.categoryLabel(recipe.category);
    final time = l10n.prepTimeMin(recipe.prepTimeMinutes);
    final isSaved = appState.isRecipeSaved(recipe.id);
    final imageUrl = recipe.imageUrl;

    return GestureDetector(
      onTap: () {
        if (_lockedPremium) {
          showPremiumFeatureModal(
            context,
            appState: appState,
            description: l10n.premiumFeatureDefaultBody,
          );
          return;
        }
        onOpenDetail();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: (imageUrl != null && imageUrl.trim().isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(recipe.emoji, style: const TextStyle(fontSize: 32)),
                        ),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)));
                        },
                      ),
                    )
                  : Center(
                      child: Text(recipe.emoji, style: const TextStyle(fontSize: 32)),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _lockedPremium
                                ? const Color(0xFFBDBDBD)
                                : const Color(0xFF1A1A2E),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      if (recipe.isPremium && !appState.isPremium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFFFE082),
                            ),
                          ),
                          child: Text(
                            '👑 ${l10n.premiumRecipeBadge}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF57F17),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      _InfoTag(icon: Icons.schedule_rounded, text: time),
                      const SizedBox(width: 6),
                      _InfoTag(icon: Icons.restaurant_rounded, text: cat),
                      if (matchPercent != null) ...[
                        const SizedBox(width: 6),
                        _InfoTag(icon: Icons.inventory_2_rounded, text: '${matchPercent!}%'),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value:
                          totalCount > 0 ? availableCount / totalCount : 0,
                      backgroundColor: const Color(0xFFF0F0F0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF66BB6A)),
                      minHeight: 5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    missingCount == 0
                        ? l10n.recipeCardAllAvailable
                        : l10n.recipeCardPartial(
                            availableCount, totalCount, missingCount),
                    style: TextStyle(
                      fontSize: 12,
                      color: missingCount == 0
                          ? const Color(0xFF66BB6A)
                          : const Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                final ok = await appState.toggleSavedRecipe(recipe.id);
                if (!ok && context.mounted) {
                  await showPremiumSavedLimitModal(context);
                }
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey(isSaved),
                  color: isSaved ? const Color(0xFFE53935) : const Color(0xFFBDBDBD),
                  size: 22,
                ),
              ),
            ),
            Icon(
              _lockedPremium ? Icons.lock_rounded : Icons.chevron_right_rounded,
              color: const Color(0xFFCCCCCC),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: const Color(0xFFBDBDBD)),
        const SizedBox(width: 3),
        Text(
          text,
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

class _Chip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _Chip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? cs.primary : cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? cs.primary : cs.outlineVariant),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
        ),
      ),
    );
  }
}
