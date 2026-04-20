import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../mock_data.dart';
import '../models/recipe.dart';
import '../widgets/premium_feature_modal.dart';
import 'add_inventory_screen.dart';
import 'recipe_detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  final AppState appState;

  const RecipeScreen({super.key, required this.appState});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool _isGenerated = false;
  String _selectedCategory = 'all';
  String _selectedCollection = 'all';

  static const _categoryKeys = [
    'all',
    'high_protein',
    'vegan',
    'low_carb',
    'quick',
    'dinner',
    'snack',
  ];
  static const _freeCollections = [
    'Vegan Haftası',
    'Bütçe Dostu',
    '5 Dakikalık',
  ];
  static const _allCollections = [
    'Vegan Haftası',
    'Bütçe Dostu',
    '5 Dakikalık',
    'Öğle Yemeği',
    'Kahvaltı',
    'Akşam',
    'Atıştırmalık',
    'Tek Tencere',
    'Protein',
    'Meze',
    'Çorba',
  ];

  List<Recipe> _filteredRecipes(AppState appState) {
    final recipes = MockData.recipes;
    if (_selectedCategory == 'all') return recipes;
    return recipes.where((r) => r.categoryKey == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          l10n.recipeSuggestions,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.appState,
        builder: (context, _) {
          final inventoryCount = widget.appState.inventory.length;
          if (inventoryCount == 0) return _buildNoInventoryState(context);
          if (!_isGenerated) return _buildPreGenerateState(context, inventoryCount);
          return _buildRecipeList(context, inventoryCount);
        },
      ),
    );
  }

  Widget _buildNoInventoryState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                color: const Color(0xFFF5F7FA),
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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.noPantryItemsSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF9E9E9E),
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

  Widget _buildPreGenerateState(BuildContext context, int inventoryCount) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Text('👨‍🍳', style: TextStyle(fontSize: 52)),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.discoverRecipes,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.personalizedRecipesBody(inventoryCount),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF9E9E9E),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => setState(() => _isGenerated = true),
                icon: const Icon(Icons.auto_awesome_rounded, size: 20),
                label: Text(l10n.generateRecipes),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: widget.appState.isPremium
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.featAiRecipeCreate),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    : () => showPremiumFeatureModal(
                          context,
                          appState: widget.appState,
                          description: l10n.premiumFeatureDefaultBody,
                        ),
                icon: Icon(
                  Icons.psychology_rounded,
                  size: 20,
                  color: widget.appState.isPremium
                      ? const Color(0xFF00ACC1)
                      : const Color(0xFFBDBDBD),
                ),
                label: Text(l10n.featAiRecipeCreate),
                style: OutlinedButton.styleFrom(
                  foregroundColor: widget.appState.isPremium
                      ? const Color(0xFF00ACC1)
                      : const Color(0xFFBDBDBD),
                  side: BorderSide(
                    color: widget.appState.isPremium
                        ? const Color(0xFF00ACC1)
                        : const Color(0xFFE0E0E0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FeatureChip(emoji: '🥚', label: l10n.fromPantry),
                const SizedBox(width: 8),
                _FeatureChip(emoji: '⚡', label: l10n.quickRecipes),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(BuildContext context, int inventoryCount) {
    final l10n = AppLocalizations.of(context)!;
    final availableCollections =
        widget.appState.isPremium ? _allCollections : _freeCollections;
    var recipes = _filteredRecipes(widget.appState);
    if (_selectedCollection != 'all') {
      recipes = recipes
          .where((r) => r.collections.contains(_selectedCollection))
          .toList(growable: false);
    }
    final dietPrefs = widget.appState.dietaryPreferences;
    if (dietPrefs.isNotEmpty) {
      recipes = recipes
          .where((r) => dietPrefs.every((p) => r.dietaryTags.contains(p)))
          .toList(growable: false);
    }
    final savedIds = widget.appState.savedRecipeIds;
    final savedRecipes = savedIds
        .map((id) => MockData.recipeById(id))
        .whereType<Recipe>()
        .toList(growable: false);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
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
                        l10n.recipesFoundCount(MockData.recipes.length),
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
                TextButton(
                  onPressed: () => setState(() => _isGenerated = false),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    l10n.refresh,
                    style: const TextStyle(
                        fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
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
              itemCount: _categoryKeys.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categoryKeys[index];
                final isSelected = cat == _selectedCategory;
                final label = l10n.categoryLabel(cat);
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF00ACC1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00ACC1)
                            : const Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF757575),
                      ),
                    ),
                  ),
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
              itemCount: 1 + _allCollections.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final label =
                    index == 0 ? l10n.collectionsAll : _allCollections[index - 1];
                final isLocked = !widget.appState.isPremium &&
                    index != 0 &&
                    !availableCollections.contains(label);
                final isSelected = (index == 0 && _selectedCollection == 'all') ||
                    (index != 0 && _selectedCollection == label);

                return GestureDetector(
                  onTap: () {
                    if (isLocked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.upgradeToPremium),
                          backgroundColor: const Color(0xFF00ACC1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                      return;
                    }
                    setState(() => _selectedCollection = index == 0 ? 'all' : label);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1A1A2E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1A1A2E)
                            : const Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isLocked) ...[
                          Icon(
                            Icons.lock_rounded,
                            size: 14,
                            color:
                                isSelected ? Colors.white : const Color(0xFF9E9E9E),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            recipe: recipe,
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
        if (recipes.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🍽️', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noRecipesInCategory,
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
                  final recipe = recipes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RecipeCard(
                      recipe: recipe,
                      appState: widget.appState,
                      onOpenDetail: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(
                            recipe: recipe,
                            appState: widget.appState,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: recipes.length,
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

  const _RecipeCard({
    required this.recipe,
    required this.appState,
    required this.onOpenDetail,
  });

  bool get _lockedPremium => recipe.isPremium && !appState.isPremium;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final missingCount = recipe.missingCount;
    final availableCount = recipe.availableCount;
    final totalCount = recipe.ingredients.length;
    final title = recipe.name;
    final cat = l10n.categoryLabel(recipe.categoryKey);
    final time = l10n.prepTimeMin(recipe.prepTimeMinutes);
    final isSaved = appState.isRecipeSaved(recipe.id);

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
              child: Center(
                child: Text(recipe.emoji,
                    style: const TextStyle(fontSize: 32)),
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
                final ok = appState.toggleSavedRecipe(recipe.id);
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

class _FeatureChip extends StatelessWidget {
  final String emoji;
  final String label;

  const _FeatureChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$emoji $label',
        style: const TextStyle(
          fontSize: 12.5,
          color: Color(0xFF00838F),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
