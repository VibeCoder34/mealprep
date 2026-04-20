import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/shopping_item.dart';
import '../models/shopping_list_bundle.dart';
import '../widgets/add_manual_shopping_item_dialog.dart';

/// Single shopping list: items, share, edit/delete list from menu.
class ShoppingListDetailScreen extends StatelessWidget {
  final String listId;
  final AppState appState;
  final VoidCallback? onGoToRecipes;

  const ShoppingListDetailScreen({
    super.key,
    required this.listId,
    required this.appState,
    this.onGoToRecipes,
  });

  void _copyToClipboard(
    BuildContext context,
    ShoppingListBundle bundle,
    List<ShoppingItem> items,
    AppLocalizations l10n,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('🛒 ${bundle.name}\n');
    if (bundle.description.trim().isNotEmpty) {
      buffer.writeln('${bundle.description.trim()}\n');
    }

    final grouped = <String, List<ShoppingItem>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.recipeId, () => []).add(item);
    }

    for (final entry in grouped.entries) {
      final title = l10n.shoppingGroupTitle(entry.key);
      buffer.writeln('── $title');
      for (final item in entry.value) {
        final check = item.isBought ? '✓' : '○';
        final name = l10n.ingredientLabel(item.name);
        final amt = l10n.formatIngredientAmount(item.amount);
        buffer.writeln('$check $name – $amt');
      }
      buffer.writeln();
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.listCopied),
        backgroundColor: const Color(0xFF00ACC1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _openAddManual(BuildContext context) {
    showAddManualShoppingItemDialog(
      context,
      appState: appState,
      listId: listId,
    );
  }

  Future<void> _confirmDelete(BuildContext context, AppLocalizations l10n) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteShoppingList),
        content: Text(l10n.deleteShoppingListConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFE53935)),
            child: Text(l10n.deleteShoppingList),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      final removed = appState.deleteShoppingList(listId);
      if (!removed && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.cannotDeleteLastList),
            backgroundColor: const Color(0xFF00ACC1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      } else if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _showEditSheet(BuildContext context, ShoppingListBundle bundle) {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController(text: bundle.name);
    final descCtrl = TextEditingController(text: bundle.description);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
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
                l10n.editShoppingList,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: l10n.shoppingListNameLabel,
                  hintText: l10n.shoppingListNameHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                decoration: InputDecoration(
                  labelText: l10n.shoppingListDescriptionLabel,
                  hintText: l10n.shoppingListDescriptionHint,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                minLines: 2,
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  appState.updateShoppingListMeta(
                    listId,
                    name: nameCtrl.text,
                    description: descCtrl.text,
                  );
                  Navigator.pop(ctx);
                },
                child: Text(l10n.saveList),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final bundle = appState.shoppingListById(listId);
        if (bundle == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) Navigator.of(context).pop();
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final items = bundle.items;
        final bought = items.where((i) => i.isBought).length;
        final remaining = items.length - bought;

        final grouped = <String, List<ShoppingItem>>{};
        for (final item in items) {
          grouped.putIfAbsent(item.recipeId, () => []).add(item);
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 1,
            surfaceTintColor: Colors.transparent,
            title: Text(
              bundle.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.5,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.ios_share_rounded,
                  color: Color(0xFF00ACC1),
                ),
                tooltip: l10n.shareTooltip,
                onPressed: items.isEmpty
                    ? null
                    : () => _copyToClipboard(context, bundle, items, l10n),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF1A1A2E)),
                onSelected: (v) {
                  if (v == 'edit') {
                    _showEditSheet(context, bundle);
                  } else if (v == 'delete') {
                    _confirmDelete(context, l10n);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(value: 'edit', child: Text(l10n.editShoppingList)),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      l10n.deleteShoppingList,
                      style: const TextStyle(color: Color(0xFFE53935)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: items.isEmpty
              ? _EmptyDetailList(
                  onGoToRecipes: onGoToRecipes,
                  onAddManual: () => _openAddManual(context),
                )
              : CustomScrollView(
                  slivers: [
                    if (bundle.description.trim().isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F7FA),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFB2EBF2)),
                            ),
                            child: Text(
                              bundle.description.trim(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF006064),
                                height: 1.45,
                              ),
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(16),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.itemsLeft(remaining),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1A1A2E),
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        l10n.itemsCompleted(bought, items.length),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF9E9E9E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0F7FA),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${items.isNotEmpty ? (bought / items.length * 100).round() : 0}%',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF00ACC1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: items.isNotEmpty ? bought / items.length : 0,
                                backgroundColor: const Color(0xFFF0F0F0),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF00ACC1),
                                ),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (final entry in grouped.entries) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.restaurant_menu_rounded,
                                size: 14,
                                color: Color(0xFF9E9E9E),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                l10n.shoppingGroupTitle(entry.key),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = entry.value[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _ShoppingItemTile(
                                  item: item,
                                  onToggle: () => appState.toggleShoppingItem(
                                    listId,
                                    item.id,
                                  ),
                                  onDelete: () => appState.removeShoppingItem(
                                    listId,
                                    item.id,
                                  ),
                                ),
                              );
                            },
                            childCount: entry.value.length,
                          ),
                        ),
                      ),
                    ],
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddManual(context),
            backgroundColor: const Color(0xFF00ACC1),
            foregroundColor: Colors.white,
            elevation: 2,
            icon: const Icon(Icons.add_rounded, size: 22),
            label: Text(
              l10n.addManualIngredientFab,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }
}

class _ShoppingItemTile extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _ShoppingItemTile({
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = l10n.ingredientLabel(item.name);
    final amt = l10n.formatIngredientAmount(item.amount);
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 4, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: item.isBought ? const Color(0xFFF5F5F5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isBought
              ? const Color(0xFFEEEEEE)
              : const Color(0xFFF0F0F0),
        ),
      ),
      child: Row(
        children: [
          Semantics(
            checked: item.isBought,
            label: l10n.shoppingBoughtSemantics,
            button: true,
            child: InkWell(
              onTap: onToggle,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: item.isBought
                        ? const Color(0xFF00ACC1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.isBought
                          ? const Color(0xFF00ACC1)
                          : const Color(0xFFBDBDBD),
                      width: 1.5,
                    ),
                  ),
                  child: item.isBought
                      ? const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onToggle,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                    color: item.isBought
                        ? const Color(0xFFBDBDBD)
                        : const Color(0xFF1A1A2E),
                    decoration:
                        item.isBought ? TextDecoration.lineThrough : null,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: l10n.shoppingDeleteItemTooltip,
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 22,
              color: item.isBought
                  ? const Color(0xFFCCCCCC)
                  : const Color(0xFFBDBDBD),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              amt,
              style: TextStyle(
                fontSize: 13.5,
                color: item.isBought
                    ? const Color(0xFFCCCCCC)
                    : const Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyDetailList extends StatelessWidget {
  final VoidCallback? onGoToRecipes;
  final VoidCallback? onAddManual;

  const _EmptyDetailList({
    this.onGoToRecipes,
    this.onAddManual,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Text('🛒', style: TextStyle(fontSize: 52)),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.emptyListDetailTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.emptyListDetailBody,
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
                onPressed: onAddManual,
                icon: const Icon(Icons.add_rounded, size: 22),
                label: Text(l10n.addManualIngredientFab),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onGoToRecipes,
                icon: const Icon(Icons.menu_book_rounded, size: 20),
                label: Text(l10n.goToRecipes),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
