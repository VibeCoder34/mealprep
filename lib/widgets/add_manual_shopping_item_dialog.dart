import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_state.dart';
import '../data/turkish_shopping_catalog.dart';
import '../l10n/app_localizations.dart';
import '../models/shopping_item.dart';

/// Shows a rounded dialog to add a manual row to the current shopping list.
Future<void> showAddManualShoppingItemDialog(
  BuildContext context, {
  required AppState appState,
  required String listId,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    useRootNavigator: true,
    builder: (ctx) => _AddManualShoppingItemDialog(
      appState: appState,
      listId: listId,
    ),
  );
}

String _formatAmountLine(double value, String unit) {
  final whole = value.roundToDouble() == value;
  final n = whole ? value.toInt().toString() : _trimDecimalString(value);
  return '$n $unit';
}

String _trimDecimalString(double value) {
  var s = value.toStringAsFixed(2);
  s = s.replaceFirst(RegExp(r'\.?0+$'), '');
  return s;
}

double? _parsePositiveQuantity(String raw) {
  final s = raw.trim().replaceAll(',', '.');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}

class _AddManualShoppingItemDialog extends StatefulWidget {
  final AppState appState;
  final String listId;

  const _AddManualShoppingItemDialog({
    required this.appState,
    required this.listId,
  });

  @override
  State<_AddManualShoppingItemDialog> createState() =>
      _AddManualShoppingItemDialogState();
}

class _AddManualShoppingItemDialogState
    extends State<_AddManualShoppingItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _nameFocus = FocusNode();
  final _qtyCtrl = TextEditingController();
  String _unit = kTurkishShoppingUnitLabels.first;
  bool _submitting = false;
  bool _showSuggestions = true;
  String? _pickedSuggestion;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        setState(() => _showSuggestions = false);
      } else {
        setState(() => _showSuggestions = true);
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _nameFocus.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  List<String> get _suggestions {
    if (!_showSuggestions) return const [];
    final q = _nameCtrl.text.trim();
    if (q.length < 2) return const [];
    if (_pickedSuggestion != null && q == _pickedSuggestion) return const [];
    return filterTurkishShoppingSuggestions(q);
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (_submitting) return;
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameCtrl.text.trim();
    final q = _parsePositiveQuantity(_qtyCtrl.text);
    if (name.isEmpty || q == null || q <= 0) return;

    setState(() => _submitting = true);
    final id = 'mi_${DateTime.now().millisecondsSinceEpoch}';
    final item = ShoppingItem(
      id: id,
      name: name,
      amount: _formatAmountLine(q, _unit),
      recipeId: 'manual',
    );
    await widget.appState.addManualShoppingItem(widget.listId, item);

    _nameCtrl.clear();
    _qtyCtrl.clear();
    setState(() {
      _unit = kTurkishShoppingUnitLabels.first;
      _pickedSuggestion = null;
      _showSuggestions = false;
    });

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final suggestions = _suggestions;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.addManualIngredientFab,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.cancel,
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).maybePop(),
                      icon: const Icon(Icons.close_rounded),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _nameCtrl,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.shoppingIngredientNameLabel,
                    hintText: l10n.shoppingIngredientNameHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onChanged: (v) {
                    if (_pickedSuggestion != null && v.trim() != _pickedSuggestion) {
                      _pickedSuggestion = null;
                      _showSuggestions = true;
                    }
                    setState(() {});
                  },
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.shoppingNameRequired;
                    }
                    return null;
                  },
                ),
                if (suggestions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Material(
                    elevation: 3,
                    shadowColor: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: suggestions.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (ctx, i) {
                          final s = suggestions[i];
                          return ListTile(
                            dense: true,
                            title: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _nameCtrl.text = s;
                              _nameCtrl.selection = TextSelection.collapsed(
                                offset: _nameCtrl.text.length,
                              );
                              setState(() {
                                _pickedSuggestion = s;
                                _showSuggestions = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _qtyCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[\d.,]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: l10n.quantity,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (v) {
                          final q = _parsePositiveQuantity(v ?? '');
                          if (q == null || q <= 0) {
                            return l10n.shoppingQuantityInvalid;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _unit,
                        decoration: InputDecoration(
                          labelText: l10n.shoppingUnitFieldLabel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        items: kTurkishShoppingUnitLabels
                            .map(
                              (u) => DropdownMenuItem<String>(
                                value: u,
                                child: Text(u),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _unit = v);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(l10n.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitting ? null : () => _submit(l10n),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _submitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2.4),
                              )
                            : Text(l10n.shoppingAddIngredientButton),
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
