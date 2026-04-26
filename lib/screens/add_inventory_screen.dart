import 'package:flutter/material.dart';
import '../app_state.dart';
import '../data/turkish_shopping_catalog.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/inventory_item.dart';
import '../services/ingredient_normalizer.dart';
import '../services/unit_system.dart';

class AddInventoryScreen extends StatefulWidget {
  final AppState appState;

  const AddInventoryScreen({super.key, required this.appState});

  @override
  State<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
          color: cs.onSurface,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.addToPantryTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: _ManualTab(appState: widget.appState),
    );
  }
}

// ─── Manual Tab ───────────────────────────────────────────────────────────────

class _ManualTab extends StatefulWidget {
  final AppState appState;

  const _ManualTab({required this.appState});

  @override
  State<_ManualTab> createState() => _ManualTabState();
}

class _ManualTabState extends State<_ManualTab> {
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _normalizer = const IngredientNormalizer();
  final _unitSystem = const UnitSystem();
  int _quantity = 1;
  String _unit = 'pcs';

  static const _units = [
    'pcs', 'g', 'kg', 'ml', 'L', 'bunch', 'box', 'bottle', 'cloves', 'head'
  ];

  static const _quickItems = [
    ('Eggs', '🥚'),
    ('Tomato', '🍅'),
    ('Cheese', '🧀'),
    ('Chicken', '🍗'),
    ('Broccoli', '🥦'),
    ('Onion', '🧅'),
    ('Potato', '🥔'),
    ('Milk', '🥛'),
    ('Bread', '🍞'),
    ('Garlic', '🧄'),
    ('Banana', '🍌'),
    ('Apple', '🍎'),
  ];

  static const _emojiMap = {
    'egg': '🥚',
    'yumurta': '🥚',
    'tomato': '🍅',
    'domates': '🍅',
    'potato': '🥔',
    'patates': '🥔',
    'onion': '🧅',
    'soğan': '🧅',
    'garlic': '🧄',
    'sarımsak': '🧄',
    'pepper': '🫑',
    'carrot': '🥕',
    'cucumber': '🥒',
    'cheese': '🧀',
    'peynir': '🧀',
    'chicken': '🍗',
    'tavuk': '🍗',
    'meat': '🥩',
    'beef': '🥩',
    'fish': '🐟',
    'salmon': '🐟',
    'milk': '🥛',
    'süt': '🥛',
    'butter': '🧈',
    'oil': '🫙',
    'flour': '🌾',
    'sugar': '🍬',
    'salt': '🧂',
    'bread': '🍞',
    'ekmek': '🍞',
    'banana': '🍌',
    'muz': '🍌',
    'apple': '🍎',
    'elma': '🍎',
    'lemon': '🍋',
    'orange': '🍊',
    'broccoli': '🥦',
    'brokoli': '🥦',
    'spinach': '🥬',
    'lettuce': '🥗',
    'mushroom': '🍄',
    'rice': '🍚',
    'pasta': '🍝',
  };

  String _getEmoji(String name) {
    final lower = name.toLowerCase();
    for (final entry in _emojiMap.entries) {
      if (lower.contains(entry.key)) return entry.value;
    }
    return '🥫';
  }

  List<String> _nameSuggestions(String raw) {
    final q = raw.trim().toLowerCase();
    if (q.isEmpty) return const [];

    final inv = widget.appState.inventory.map((i) => i.name).toList(growable: false);
    final catalog = filterTurkishShoppingSuggestions(q);

    // De-dupe by normalized key so "Domates" and "domates" appear once.
    final byKey = <String, String>{};

    void addCandidate(String s) {
      final raw = s.trim();
      if (raw.isEmpty) return;
      final key = _normalizer.normalize(raw);
      if (key.isEmpty) return;
      byKey.putIfAbsent(key, () => raw);
    }

    for (final s in inv) addCandidate(s);
    for (final s in catalog) addCandidate(s);

    final sorted = byKey.values.toList(growable: false)
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    final matches = <String>[];
    for (final s in sorted) {
      if (s.toLowerCase().contains(q)) {
        matches.add(s);
        if (matches.length >= 8) break;
      }
    }
    return matches;
  }

  Future<void> _showUnitMismatchDialog({
    required String typedName,
    required String existingName,
    required String existingUnit,
    required String pickedUnit,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.inventoryUnitMismatchTitle),
        content: Text(
          l10n.inventoryUnitMismatchBody(
            l10n.ingredientLabel(existingName),
            l10n.unitLabel(existingUnit),
            l10n.unitLabel(pickedUnit),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: cs.primary),
            onPressed: () {
              setState(() => _unit = existingUnit);
              Navigator.of(ctx).pop();
            },
            child: Text(l10n.inventoryUseExistingUnitCta),
          ),
        ],
      ),
    );
  }

  Future<void> _addItem() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final itemKey = _normalizer.normalize(name);
    final unitGroup = _unitSystem.groupKey(_unitSystem.groupOf(_unit));

    try {
      await widget.appState.addItem(InventoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        emoji: _getEmoji(name),
        quantity: _quantity,
        unit: _unit,
        itemKey: itemKey,
        unitGroup: unitGroup,
      ));
    } on StateError catch (e) {
      // Prevent crashes for unit mismatch; guide user to a compatible unit instead.
      if (!mounted) return;
      final existing = widget.appState.inventory.cast<InventoryItem?>().firstWhere(
            (i) => i != null && _normalizer.normalize(i.name) == itemKey,
            orElse: () => null,
          );

      if (e.message == 'unit_group_mismatch' && existing != null) {
        await _showUnitMismatchDialog(
          typedName: name,
          existingName: existing.name,
          existingUnit: existing.unit,
          pickedUnit: _unit,
        );
        return;
      }

      final l10n = AppLocalizations.of(context)!;
      final cs = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.inventoryAddFailedToast),
          backgroundColor: cs.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      final cs = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.inventoryAddFailedToast),
          backgroundColor: cs.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.itemAdded(name)),
        backgroundColor: cs.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() {
      _nameController.clear();
      _quantity = 1;
      _unit = 'pcs';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(l10n.itemName),
          const SizedBox(height: 8),
          RawAutocomplete<String>(
            textEditingController: _nameController,
            focusNode: _nameFocusNode,
            optionsBuilder: (value) => _nameSuggestions(value.text),
            displayStringForOption: (o) => o,
            onSelected: (o) => setState(() => _nameController.text = o),
            fieldViewBuilder: (context, ctrl, focus, onSubmit) {
              return TextField(
                controller: ctrl,
                focusNode: focus,
                textCapitalization: TextCapitalization.words,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: l10n.nameHint,
                  hintStyle: TextStyle(color: cs.onSurfaceVariant, fontWeight: FontWeight.w400),
                  prefixIcon: Icon(Icons.search_rounded, color: cs.onSurfaceVariant, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addItem(),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              if (options.isEmpty) return const SizedBox.shrink();
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(14),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 260, maxWidth: 520),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      itemCount: options.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final o = options.elementAt(index);
                        return ListTile(
                          dense: true,
                          leading: Text(_getEmoji(o), style: const TextStyle(fontSize: 20)),
                          title: Text(l10n.ingredientLabel(o)),
                          onTap: () => onSelected(o),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _FieldLabel(l10n.quantity),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Row(
                  children: [
                    _BigStepBtn(
                      icon: Icons.remove_rounded,
                      enabled: _quantity > 1,
                      onTap: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    SizedBox(
                      width: 44,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                    _BigStepBtn(
                      icon: Icons.add_rounded,
                      enabled: true,
                      onTap: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _unit,
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      items: _units
                          .map((u) => DropdownMenuItem(
                                value: u,
                                child: Text(l10n.unitLabel(u)),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _unit = v!),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
              label: Text(l10n.addToPantryButton),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          const SizedBox(height: 20),
          _FieldLabel(l10n.quickAdd),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickItems.map((item) {
              final name = item.$1;
              final emoji = item.$2;
              final label = l10n.ingredientLabel(name);
              return GestureDetector(
                onTap: () => setState(
                    () => _nameController.text = l10n.ingredientLabel(name)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 13, vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Text(
                    '$emoji  $label',
                    style: TextStyle(fontSize: 13.5, color: cs.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _BigStepBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _BigStepBtn({required this.icon, required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 54,
        decoration: BoxDecoration(
          color: enabled ? cs.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          size: 22,
          color: enabled ? cs.primary : cs.outlineVariant,
        ),
      ),
    );
  }
}
