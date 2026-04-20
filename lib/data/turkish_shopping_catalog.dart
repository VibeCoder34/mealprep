// Turkish market–focused suggestion data for manual shopping list entry.
// Kept as constants for easy future i18n / remote config.

/// Common grocery items (Turkish names).
const List<String> kTurkishCommonShoppingItems = [
  'Domates',
  'Soğan',
  'Sarımsak',
  'Tavuk Göğsü',
  'Yumurta',
  'Pirinç',
  'Makarna',
  'Salça',
  'Zeytinyağı',
  'Süt',
  'Peynir',
  'Ekmek',
  'Muz',
  'Elma',
  'Portakal',
  'Lahana',
  'Brokoli',
  'Patates',
  'Tavuk Kanat',
  'Kıyma',
];

/// Turkish-style units shown in the manual add flow.
const List<String> kTurkishShoppingUnitLabels = [
  'kg',
  'gram',
  'adet',
  'ml',
  'litre',
  'paket',
  'kaşık',
  'bardak',
];

List<String> filterTurkishShoppingSuggestions(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return const [];
  return kTurkishCommonShoppingItems
      .where((e) => e.toLowerCase().contains(q))
      .toList(growable: false);
}
