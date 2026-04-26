class IngredientNormalizer {
  const IngredientNormalizer();

  String normalize(String input) {
    var s = input.trim().toLowerCase();
    if (s.isEmpty) return s;

    // Remove punctuation commonly present in ingredient lines.
    s = s.replaceAll(RegExp(r'[^\p{L}\p{N}\s]+', unicode: true), ' ');
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Basic Turkish char folding to improve matching (ı/i, ş/s, ç/c, ğ/g, ö/o, ü/u).
    s = s
        .replaceAll('ı', 'i')
        .replaceAll('ş', 's')
        .replaceAll('ç', 'c')
        .replaceAll('ğ', 'g')
        .replaceAll('ö', 'o')
        .replaceAll('ü', 'u');

    // Heuristic synonyms / canonicalization (keep short and safe).
    s = _applySynonyms(s);
    return s;
  }

  String _applySynonyms(String s) {
    // Canonical meats
    if (s.contains('tavuk')) return 'tavuk';
    if (s.contains('hindi')) return 'hindi';
    if (s.contains('kirma') && s.contains('et')) return 'kirma et';

    // Common produce
    if (s.contains('domates')) return 'domates';
    if (s.contains('salatalik')) return 'salatalik';
    if (s.contains('biber')) return 'biber';
    if (s.contains('sogan')) return 'sogan';
    if (s.contains('sarimsak')) return 'sarimsak';
    if (s.contains('limon')) return 'limon';

    // Dairy/eggs
    if (s.contains('yumurta')) return 'yumurta';
    if (s.contains('sut')) return 'sut';
    if (s.contains('peynir')) return 'peynir';
    if (s.contains('yogurt')) return 'yogurt';

    // Staples
    if (s.contains('bulgur')) return 'bulgur';
    if (s.contains('pirinc')) return 'pirinc';
    if (s.contains('makarna')) return 'makarna';
    if (s.contains('un')) return 'un';

    return s;
  }
}

