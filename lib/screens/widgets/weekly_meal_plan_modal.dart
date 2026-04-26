import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../app_state.dart';
import '../../l10n/app_localizations.dart';
import '../../models/shopping_item.dart';
import '../../services/ai_service.dart';
import '../../widgets/premium_feature_modal.dart';

Future<void> showWeeklyMealPlanModal(
  BuildContext context, {
  required AppState appState,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _WeeklyMealPlanModal(appState: appState),
  );
}

class _WeeklyMealPlanModal extends StatefulWidget {
  final AppState appState;
  const _WeeklyMealPlanModal({required this.appState});

  @override
  State<_WeeklyMealPlanModal> createState() => _WeeklyMealPlanModalState();
}

class _WeeklyMealPlanModalState extends State<_WeeklyMealPlanModal> {
  static const _dayOptions = <(String, String)>[
    ('Pazartesi', 'Pzt'),
    ('Salı', 'Sal'),
    ('Çarşamba', 'Çar'),
    ('Perşembe', 'Per'),
    ('Cuma', 'Cum'),
    ('Cumartesi', 'Cts'),
    ('Pazar', 'Paz'),
  ];

  final Set<String> _days = _dayOptions.map((d) => d.$1).toSet();
  String? _totalCalories;

  bool _loading = false;
  String? _errorKey;
  WeeklyMealPlan? _plan;

  AIService _service() => AIService(apiKey: dotenv.env['OPENAI_API_KEY'] ?? '');

  Future<void> _generate() async {
    if (!widget.appState.isPremium) {
      await showPremiumFeatureModal(context, appState: widget.appState);
      return;
    }

    setState(() {
      _loading = true;
      _errorKey = null;
      _plan = null;
    });

    final res = await _service().generateWeeklyMealPlan(
      days: _days.toList(growable: false),
      dietaryPreferences: widget.appState.dietaryPreferences,
      totalCalorieTarget: _totalCalories == 'any' ? null : _totalCalories,
    );

    if (!mounted) return;
    if (!res.isOk || res.data == null) {
      setState(() {
        _loading = false;
        _errorKey = _mapAIError(res.error);
      });
      return;
    }
    setState(() {
      _loading = false;
      _plan = res.data;
    });
  }

  String _mapAIError(AIError? e) {
    switch (e) {
      case AIError.network:
        return 'ai_network';
      case AIError.rateLimited:
        return 'ai_rate_limited';
      case AIError.invalidResponse:
        return 'ai_invalid_response';
      case AIError.misconfigured:
        return 'ai_misconfigured';
      default:
        return 'ai_unknown';
    }
  }

  String _errorText(AppLocalizations l10n, String key) {
    switch (key) {
      case 'ai_network':
        return l10n.aiConnectionError;
      case 'ai_rate_limited':
        return l10n.aiRateLimited;
      case 'ai_invalid_response':
        return l10n.aiInvalidResponse;
      case 'ai_misconfigured':
        return l10n.aiMisconfigured;
      default:
        return l10n.aiUnknownError;
    }
  }

  Future<void> _addAllToShopping() async {
    final plan = _plan;
    if (plan == null) return;
    final listId = widget.appState.defaultTargetListId;
    if (listId == null) return;

    final items = <ShoppingItem>[];
    for (final d in plan.days) {
      for (final ing in d.ingredients) {
        items.add(
          ShoppingItem(
            id: 'mealplan_${d.day}_${ing.name}_${DateTime.now().millisecondsSinceEpoch}',
            name: ing.name,
            amount: ing.amount,
            recipeId: 'mealplan',
          ),
        );
      }
    }
    await widget.appState.addShoppingItems(listId, items);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.mealPlanAddedToShopping),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
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
                  l10n.mealPlanCreateTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
                ),
                const SizedBox(height: 12),
                Text(l10n.mealPlanDaysLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final d in _dayOptions)
                      FilterChip(
                        selected: _days.contains(d.$1),
                        label: Text(d.$2),
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              _days.add(d.$1);
                            } else {
                              _days.remove(d.$1);
                            }
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                _dropdown(
                  label: l10n.mealPlanTotalCaloriesLabel,
                  value: _totalCalories,
                  items: const [
                    ('any', 'İsteğe bağlı'),
                    ('1500', '1500'),
                    ('2000', '2000'),
                    ('2500', '2500'),
                  ],
                  onChanged: (v) => setState(() => _totalCalories = v),
                ),
                const SizedBox(height: 14),
                if (_errorKey != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.errorContainer.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cs.errorContainer),
                    ),
                    child: Text(_errorText(l10n, _errorKey!), style: TextStyle(color: cs.error)),
                  ),
                  const SizedBox(height: 10),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _generate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: _loading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Text(l10n.mealPlanGenerating),
                            ],
                          )
                        : Text(l10n.mealPlanGenerateButton, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                if (_plan != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF0F0F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.mealPlanCreated, style: const TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        for (final d in _plan!.days)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 46,
                                  child: Text(d.day, style: const TextStyle(fontWeight: FontWeight.w800)),
                                ),
                                Expanded(child: Text(d.recipeName)),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _addAllToShopping,
                            child: Text(l10n.mealPlanAddAllToShopping),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<(String, String)> items,
    required void Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value ?? 'any',
          isExpanded: true,
          items: [
            for (final it in items)
              DropdownMenuItem(
                value: it.$1,
                child: Text(it.$2),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

