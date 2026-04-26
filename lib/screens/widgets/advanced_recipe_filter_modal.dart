import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/recipe_filter.dart';

Future<RecipeFilter?> showAdvancedRecipeFilterModal(
  BuildContext context, {
  required RecipeFilter current,
}) {
  return showModalBottomSheet<RecipeFilter>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _AdvancedRecipeFilterModal(current: current),
  );
}

class _AdvancedRecipeFilterModal extends StatefulWidget {
  final RecipeFilter current;
  const _AdvancedRecipeFilterModal({required this.current});

  @override
  State<_AdvancedRecipeFilterModal> createState() => _AdvancedRecipeFilterModalState();
}

class _AdvancedRecipeFilterModalState extends State<_AdvancedRecipeFilterModal> {
  late int? _maxPrep;
  late final TextEditingController _minCalCtrl;
  late final TextEditingController _maxCalCtrl;
  late final Set<String> _difficulties;
  late final TextEditingController _excludeCtrl;
  late final TextEditingController _favoriteCtrl;

  @override
  void initState() {
    super.initState();
    _maxPrep = widget.current.maxPrepTimeMinutes;
    _minCalCtrl = TextEditingController(text: widget.current.minCalories?.toString() ?? '');
    _maxCalCtrl = TextEditingController(text: widget.current.maxCalories?.toString() ?? '');
    _difficulties = Set<String>.from(widget.current.difficulties);
    _excludeCtrl = TextEditingController(text: widget.current.excludeIngredients.join(', '));
    _favoriteCtrl = TextEditingController(text: widget.current.favoriteIngredients.join(', '));
  }

  @override
  void dispose() {
    _minCalCtrl.dispose();
    _maxCalCtrl.dispose();
    _excludeCtrl.dispose();
    _favoriteCtrl.dispose();
    super.dispose();
  }

  Set<String> _parseCsv(String s) {
    return s
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet();
  }

  RecipeFilter _build() {
    final minCal = int.tryParse(_minCalCtrl.text.trim());
    final maxCal = int.tryParse(_maxCalCtrl.text.trim());
    return widget.current.copyWith(
      maxPrepTimeMinutes: _maxPrep,
      minCalories: minCal,
      maxCalories: maxCal,
      difficulties: Set<String>.from(_difficulties),
      excludeIngredients: _parseCsv(_excludeCtrl.text),
      favoriteIngredients: _parseCsv(_favoriteCtrl.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.advancedFiltersTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<int?>(
                  value: _maxPrep,
                  decoration: InputDecoration(
                    labelText: l10n.filterCookTime,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  items: [
                    DropdownMenuItem(value: null, child: Text(l10n.filterAny)),
                    DropdownMenuItem(value: 15, child: Text(l10n.filterUpToMinutes(15))),
                    DropdownMenuItem(value: 30, child: Text(l10n.filterUpToMinutes(30))),
                    DropdownMenuItem(value: 45, child: Text(l10n.filterUpToMinutes(45))),
                    DropdownMenuItem(value: 999, child: Text(l10n.filter45Plus)),
                  ],
                  onChanged: (v) => setState(() => _maxPrep = v),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minCalCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.filterCaloriesMin,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _maxCalCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.filterCaloriesMax,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(l10n.filterDifficulty, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                _DifficultyCheck(
                  label: l10n.difficultyVeryEasy,
                  value: _difficulties.contains('Çok Kolay'),
                  onChanged: (v) => setState(() {
                    v ? _difficulties.add('Çok Kolay') : _difficulties.remove('Çok Kolay');
                  }),
                ),
                _DifficultyCheck(
                  label: l10n.difficultyEasy,
                  value: _difficulties.contains('Kolay'),
                  onChanged: (v) => setState(() {
                    v ? _difficulties.add('Kolay') : _difficulties.remove('Kolay');
                  }),
                ),
                _DifficultyCheck(
                  label: l10n.difficultyMedium,
                  value: _difficulties.contains('Orta'),
                  onChanged: (v) => setState(() {
                    v ? _difficulties.add('Orta') : _difficulties.remove('Orta');
                  }),
                ),
                _DifficultyCheck(
                  label: l10n.difficultyHard,
                  value: _difficulties.contains('Zor'),
                  onChanged: (v) => setState(() {
                    v ? _difficulties.add('Zor') : _difficulties.remove('Zor');
                  }),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _excludeCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.filterExcludeIngredients,
                    helperText: l10n.filterCommaSeparatedHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _favoriteCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.filterFavoriteIngredients,
                    helperText: l10n.filterCommaSeparatedHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(RecipeFilter.empty),
                        child: Text(l10n.clearAll),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(_build()),
                        child: Text(l10n.applyFilters),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DifficultyCheck extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _DifficultyCheck({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: (v) => onChanged(v == true),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

