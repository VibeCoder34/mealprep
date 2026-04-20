import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/shopping_list_bundle.dart';
import 'shopping_list_detail_screen.dart';

/// Hub: all shopping lists; open a list for items or create a new list.
class ShoppingListScreen extends StatelessWidget {
  final AppState appState;
  final VoidCallback? onGoToRecipes;

  const ShoppingListScreen({
    super.key,
    required this.appState,
    this.onGoToRecipes,
  });

  void _openDetail(BuildContext context, String listId) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => ShoppingListDetailScreen(
          listId: listId,
          appState: appState,
          onGoToRecipes: onGoToRecipes,
        ),
      ),
    );
  }

  void _showCreateListSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();

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
                l10n.newShoppingList,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                autofocus: true,
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
                  final id = appState.createShoppingList(
                    name: nameCtrl.text,
                    description: descCtrl.text,
                  );
                  Navigator.pop(ctx);
                  _openDetail(context, id);
                },
                child: Text(l10n.createShoppingList),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatShoppingListMarkdown(
    ShoppingListBundle bundle,
    AppLocalizations l10n,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('🛒 ${l10n.shoppingListTitle}\n');
    if (bundle.name.trim().isNotEmpty) {
      buffer.writeln('_${bundle.name.trim()}_\n');
    }
    for (final item in bundle.items) {
      final name = l10n.ingredientLabel(item.name);
      final amt = l10n.formatIngredientAmount(item.amount);
      buffer.writeln('- $name ($amt)');
    }
    return buffer.toString().trim();
  }

  void _sharePreferredList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lists = appState.shoppingLists;
    if (lists.isEmpty) return;
    final id = appState.defaultTargetListId ?? lists.first.id;
    final bundle = appState.shoppingListById(id) ?? lists.first;
    final text = _formatShoppingListMarkdown(bundle, l10n);

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.copiedToClipboard),
        backgroundColor: const Color(0xFF00ACC1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final lists = appState.shoppingLists;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 1,
            surfaceTintColor: Colors.transparent,
            title: Text(
              l10n.shoppingListsTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.5,
              ),
            ),
            actions: [
              if (lists.isNotEmpty)
                IconButton(
                  tooltip: l10n.shareTooltip,
                  onPressed: () => _sharePreferredList(context),
                  icon: const Icon(
                    Icons.ios_share_rounded,
                    color: Color(0xFF00ACC1),
                  ),
                ),
              const SizedBox(width: 4),
            ],
          ),
          body: lists.isEmpty
              ? _EmptyHub(
                  onCreate: () => _showCreateListSheet(context),
                  onGoToRecipes: onGoToRecipes,
                  l10n: l10n,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                    final list = lists[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ShoppingListCard(
                        bundle: list,
                        l10n: l10n,
                        onTap: () => _openDetail(context, list.id),
                      ),
                    );
                  },
                ),
          floatingActionButton: lists.isEmpty
              ? null
              : FloatingActionButton.extended(
                  onPressed: () => _showCreateListSheet(context),
                  backgroundColor: const Color(0xFF00ACC1),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  icon: const Icon(Icons.add_rounded, size: 22),
                  label: Text(
                    l10n.newShoppingList,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
        );
      },
    );
  }
}

class _ShoppingListCard extends StatelessWidget {
  final ShoppingListBundle bundle;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  const _ShoppingListCard({
    required this.bundle,
    required this.l10n,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = bundle.itemCount;
    final bought = bundle.boughtCount;
    final pct = total > 0 ? bought / total : 0.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text('🛒', style: TextStyle(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bundle.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                            letterSpacing: -0.3,
                          ),
                        ),
                        if (bundle.description.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            bundle.description.trim(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: Color(0xFF9E9E9E),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCCCCCC),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                total == 0
                    ? l10n.listItemsCount(0)
                    : '${l10n.listItemsCount(total)} · ${l10n.shoppingListProgress(bought, total)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: total > 0 ? pct : 0,
                  backgroundColor: const Color(0xFFF0F0F0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF00ACC1),
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyHub extends StatelessWidget {
  final VoidCallback onCreate;
  final VoidCallback? onGoToRecipes;
  final AppLocalizations l10n;

  const _EmptyHub({
    required this.onCreate,
    this.onGoToRecipes,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Text('📝', style: TextStyle(fontSize: 52)),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.emptyShoppingTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.emptyShoppingBody,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF9E9E9E),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.add_rounded, size: 22),
                label: Text(l10n.newShoppingList),
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
