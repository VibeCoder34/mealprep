import 'dart:async';

import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/inventory_item.dart';

class InventoryScreen extends StatefulWidget {
  final AppState appState;

  const InventoryScreen({super.key, required this.appState});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _searchCtrl = TextEditingController();
  Timer? _searchDebounce;
  List<InventoryItem> _sortedItems = const [];

  static const _units = <String>[
    'adet',
    'pcs',
    'g',
    'kg',
    'ml',
    'L',
    'yk',
    'tk',
    'bunch',
    'box',
    'bottle',
    'cloves',
    'head',
  ];

  @override
  void initState() {
    super.initState();
    widget.appState.addListener(_onAppStateChanged);
    _rebuildSortedItems();
    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onAppStateChanged() {
    // Avoid doing heavy work (sort) on every keystroke; only when inventory changes.
    _rebuildSortedItems();
  }

  void _rebuildSortedItems() {
    final next = widget.appState.inventory.toList(growable: false)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    _sortedItems = next;
    if (mounted) setState(() {});
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 120), () {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    widget.appState.removeListener(_onAppStateChanged);
    _searchDebounce?.cancel();
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  List<InventoryItem> _filtered(List<InventoryItem> items) {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((i) => i.name.toLowerCase().contains(q)).toList(growable: false);
  }

  Future<void> _openEditSheet(BuildContext context, InventoryItem item) async {
    final cs = Theme.of(context).colorScheme;

    final nameCtrl = TextEditingController(text: item.name);
    final qtyCtrl = TextEditingController(text: item.quantity.toString());
    final emojiCtrl = TextEditingController(text: item.emoji);
    var unit = item.unit;

    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: cs.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        builder: (ctx) {
          var saving = false;
          Future<void> save() async {
            if (saving) return;
            FocusScope.of(ctx).unfocus();
            saving = true;
            final qty = int.tryParse(qtyCtrl.text.trim()) ?? item.quantity;
            await widget.appState.updateItem(
              item.id,
              name: nameCtrl.text,
              emoji: emojiCtrl.text,
              quantity: qty,
              unit: unit,
            );
            if (!ctx.mounted) return;
            Navigator.of(ctx).pop();

            if (!context.mounted) return;
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.inventorySavedToast),
                backgroundColor: Theme.of(context).colorScheme.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
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
                        color: Theme.of(ctx).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(ctx)!.inventoryEditItemTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(ctx).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(ctx)!.inventoryItemNameLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => save(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtyCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(ctx)!.inventoryAmountLabel,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => save(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainer,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: cs.outlineVariant),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _units.contains(unit) ? unit : _units.first,
                              isExpanded: true,
                              items: _units
                                  .map((u) => DropdownMenuItem(
                                        value: u,
                                        child: Text(AppLocalizations.of(ctx)!.unitLabel(u)),
                                      ))
                                  .toList(),
                              onChanged: (v) => setState(() => unit = v ?? unit),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emojiCtrl,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(ctx)!.inventoryEmojiLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => save(),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: saving ? null : save,
                    child: saving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.4),
                          )
                        : Text(AppLocalizations.of(ctx)!.ratingSave),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(AppLocalizations.of(ctx)!.cancel),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } finally {
      nameCtrl.dispose();
      qtyCtrl.dispose();
      emojiCtrl.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          l10n.yourPantry,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.appState,
        builder: (context, _) {
          final items = _sortedItems;
          final filtered = _filtered(items);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: l10n.inventorySearchHint,
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    filled: true,
                    fillColor: cs.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('📦', style: TextStyle(fontSize: 56)),
                              const SizedBox(height: 14),
                              Text(
                                items.isEmpty
                                    ? l10n.inventoryEmptyTitle
                                    : l10n.inventoryNoResults,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: cs.onSurface,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                items.isEmpty
                                    ? l10n.inventoryEmptyBody
                                    : l10n.inventoryTryDifferentSearch,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  color: cs.onSurfaceVariant,
                                  height: 1.55,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final label = l10n.ingredientLabel(item.name);
                          final unit = l10n.unitLabel(item.unit);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Dismissible(
                              key: Key(item.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => widget.appState.removeItem(item.id),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 22),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _openEditSheet(context, item),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                                    decoration: BoxDecoration(
                                      color: cs.surface,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: cs.outlineVariant),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: cs.surfaceContainer,
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
                                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                      fontWeight: FontWeight.w700,
                                                      letterSpacing: -0.2,
                                                    ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                '${item.quantity} $unit',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: cs.onSurfaceVariant,
                                                      fontSize: 13.5,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.edit_rounded, color: cs.outlineVariant, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

