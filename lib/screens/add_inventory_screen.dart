import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_extensions.dart';
import '../models/inventory_item.dart';

class AddInventoryScreen extends StatefulWidget {
  final AppState appState;

  const AddInventoryScreen({super.key, required this.appState});

  @override
  State<AddInventoryScreen> createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
          color: const Color(0xFF1A1A2E),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.addToPantryTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF00ACC1),
              unselectedLabelColor: const Color(0xFF9E9E9E),
              indicatorColor: const Color(0xFF00ACC1),
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14.5),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14.5),
              tabs: [
                Tab(text: '📷  ${l10n.tabPhoto}'),
                Tab(text: '✏️  ${l10n.tabManual}'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PhotoTab(appState: widget.appState),
          _ManualTab(appState: widget.appState),
        ],
      ),
    );
  }
}

// ─── Photo Tab ────────────────────────────────────────────────────────────────

class _PhotoTab extends StatefulWidget {
  final AppState appState;

  const _PhotoTab({required this.appState});

  @override
  State<_PhotoTab> createState() => _PhotoTabState();
}

class _PhotoTabState extends State<_PhotoTab> {
  bool _hasScanned = false;
  final List<_DetectedItem> _detectedItems = [];

  void _simulateScan() {
    setState(() {
      _hasScanned = true;
      _detectedItems
        ..clear()
        ..addAll([
          _DetectedItem(name: 'Tomato', emoji: '🍅', quantity: 3, unit: 'pcs'),
          _DetectedItem(name: 'Cucumber', emoji: '🥒', quantity: 2, unit: 'pcs'),
          _DetectedItem(name: 'Cheese', emoji: '🧀', quantity: 150, unit: 'g'),
          _DetectedItem(name: 'Parsley', emoji: '🌿', quantity: 1, unit: 'bunch'),
        ]);
    });
  }

  void _addAll() {
    final l10n = AppLocalizations.of(context)!;
    final count = _detectedItems.length;
    for (final item in _detectedItems) {
      widget.appState.addItem(InventoryItem(
        id: '${DateTime.now().millisecondsSinceEpoch}_${item.name}',
        name: item.name,
        emoji: item.emoji,
        quantity: item.quantity,
        unit: item.unit,
      ));
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.itemsAddedToPantry(count)),
        backgroundColor: const Color(0xFF00ACC1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _hasScanned ? _buildResultsView() : _buildCameraView();
  }

  Widget _buildCameraView() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _simulateScan,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _IconBox(
                    icon: Icons.camera_alt_outlined,
                    color: Color(0xFF00ACC1),
                    bg: Color(0xFFE0F7FA),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.cameraPreview,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF424242),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.cameraHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF9E9E9E),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _simulateScan,
            icon: const Icon(Icons.camera_alt_rounded, size: 20),
            label: Text(l10n.takePhoto),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _simulateScan,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF00ACC1),
              side: const BorderSide(color: Color(0xFF00ACC1), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 15),
            ),
            icon: const Icon(Icons.photo_library_outlined, size: 20),
            label: Text(l10n.chooseFromLibrary),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFFE082)),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.aiPhotoTip,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6D4C41),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Text('✅', style: TextStyle(fontSize: 17)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.itemsDetectedBanner(_detectedItems.length),
                  style: const TextStyle(
                    color: Color(0xFF00695C),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _hasScanned = false),
                child: Text(
                  l10n.retake,
                  style: const TextStyle(
                    color: Color(0xFF00ACC1),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: _detectedItems.length,
            itemBuilder: (context, index) {
              final item = _detectedItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _DetectedItemTile(
                  item: item,
                  onRemove: () =>
                      setState(() => _detectedItems.removeAt(index)),
                  onQuantityChanged: (q) =>
                      setState(() => item.quantity = q),
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _detectedItems.isEmpty ? null : _addAll,
                child: Text(l10n.addAllCount(_detectedItems.length)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetectedItem {
  final String name;
  final String emoji;
  int quantity;
  final String unit;

  _DetectedItem({
    required this.name,
    required this.emoji,
    required this.quantity,
    required this.unit,
  });
}

class _DetectedItemTile extends StatelessWidget {
  final _DetectedItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  const _DetectedItemTile({
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(item.emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.ingredientLabel(item.name),
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          _MiniStepper(
            value: item.quantity,
            onDecrement:
                item.quantity > 1 ? () => onQuantityChanged(item.quantity - 1) : null,
            onIncrement: () => onQuantityChanged(item.quantity + 1),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: Color(0xFFFF5252)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStepper extends StatelessWidget {
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;

  const _MiniStepper({
    required this.value,
    this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepBtn(icon: Icons.remove_rounded, enabled: onDecrement != null, onTap: onDecrement),
        SizedBox(
          width: 32,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        _StepBtn(icon: Icons.add_rounded, enabled: true, onTap: onIncrement),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _StepBtn({required this.icon, required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFE0F7FA) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 17,
          color: enabled ? const Color(0xFF00ACC1) : const Color(0xFFCCCCCC),
        ),
      ),
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
    'tomato': '🍅',
    'potato': '🥔',
    'onion': '🧅',
    'garlic': '🧄',
    'pepper': '🫑',
    'carrot': '🥕',
    'cucumber': '🥒',
    'cheese': '🧀',
    'chicken': '🍗',
    'meat': '🥩',
    'beef': '🥩',
    'fish': '🐟',
    'salmon': '🐟',
    'milk': '🥛',
    'butter': '🧈',
    'oil': '🫙',
    'flour': '🌾',
    'sugar': '🍬',
    'salt': '🧂',
    'bread': '🍞',
    'banana': '🍌',
    'apple': '🍎',
    'lemon': '🍋',
    'orange': '🍊',
    'broccoli': '🥦',
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

  void _addItem() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    widget.appState.addItem(InventoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      emoji: _getEmoji(name),
      quantity: _quantity,
      unit: _unit,
    ));

    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.itemAdded(name)),
        backgroundColor: const Color(0xFF00ACC1),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(l10n.itemName),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(
              fontSize: 15.5,
              color: Color(0xFF1A1A2E),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: l10n.nameHint,
              hintStyle: const TextStyle(
                  color: Color(0xFFBDBDBD), fontWeight: FontWeight.w400),
              prefixIcon: const Icon(Icons.edit_outlined,
                  color: Color(0xFFBDBDBD), size: 20),
              filled: true,
              fillColor: const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: Color(0xFF00ACC1), width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 24),
          _FieldLabel(l10n.quantity),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE8E8E8)),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
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
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _unit,
                      isExpanded: true,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
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
          const Divider(color: Color(0xFFF0F0F0), height: 1),
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
                onTap: () => setState(() => _nameController.text = name),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 13, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Text(
                    '$emoji  $label',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF424242),
                      fontWeight: FontWeight.w500,
                    ),
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
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF757575),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 54,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFE0F7FA) : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          size: 22,
          color: enabled ? const Color(0xFF00ACC1) : const Color(0xFFCCCCCC),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;

  const _IconBox({required this.icon, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Icon(icon, size: 38, color: color),
    );
  }
}
