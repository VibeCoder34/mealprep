import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/inventory_item.dart';
import 'add_inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;

  const HomeScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final inventory = appState.inventory;
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                snap: true,
                elevation: 0,
                scrolledUnderElevation: 1,
                surfaceTintColor: Colors.transparent,
                title: Row(
                  children: [
                    const Text('🥗', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      l10n.myKitchen,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFE0F7FA),
                      child: Text(
                        'K',
                        style: TextStyle(
                          color: Color(0xFF00ACC1),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _HeroBanner(onTap: () => _navigateToAdd(context)),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 28, 16, 10),
                  child: Row(
                    children: [
                      Text(
                        l10n.yourPantry,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F7FA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          l10n.totalItemsCount(inventory.length),
                          style: const TextStyle(
                            color: Color(0xFF00838F),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (inventory.isNotEmpty && inventory.length < 3)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: _LowInventoryHint(
                      onAdd: () => _navigateToAdd(context),
                    ),
                  ),
                ),
              if (inventory.isEmpty)
                SliverFillRemaining(
                  child: _EmptyInventory(onAdd: () => _navigateToAdd(context)),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = inventory[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _InventoryCard(
                            item: item,
                            onDelete: () => appState.removeItem(item.id),
                          ),
                        );
                      },
                      childCount: inventory.length,
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _navigateToAdd(context),
            backgroundColor: const Color(0xFF00ACC1),
            foregroundColor: Colors.white,
            elevation: 2,
            icon: const Icon(Icons.add_rounded, size: 22),
            label: Text(
              l10n.addItem,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        );
      },
    );
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddInventoryScreen(appState: appState),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _HeroBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 148,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.addToPantry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.takePhotoOrManual,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.getStarted,
                          style: const TextStyle(
                            color: Color(0xFF00ACC1),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF00ACC1),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text('📷', style: TextStyle(fontSize: 62)),
          ],
        ),
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onDelete;

  const _InventoryCard({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label = l10n.ingredientLabel(item.name);
    final unit = l10n.unitLabel(item.unit);
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 22),
        decoration: BoxDecoration(
          color: const Color(0xFFFF5252),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(
              l10n.delete,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Center(
                child: Text(item.emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.quantity} $unit',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFFCCCCCC), size: 22),
          ],
        ),
      ),
    );
  }
}

class _LowInventoryHint extends StatelessWidget {
  final VoidCallback onAdd;

  const _LowInventoryHint({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 11, 8, 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        children: [
          const Text('💡', style: TextStyle(fontSize: 17)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.lowInventoryHint,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF795548),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: onAdd,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00ACC1),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              l10n.addMoreShort,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyInventory extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyInventory({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🛒', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 18),
            Text(
              l10n.pantryEmpty,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.pantryEmptySubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9E9E9E),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text(l10n.addFirstItem),
            ),
          ],
        ),
      ),
    );
  }
}
