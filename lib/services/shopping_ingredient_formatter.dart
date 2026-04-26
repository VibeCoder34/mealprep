import 'ingredient_normalizer.dart';

/// V1 rule-based formatter that converts recipe-phrasing into a shopping-friendly name.
///
/// - Removes prep/form adjectives like "rendelenmiş", "doğranmış", "büyük boy".
/// - Skips pantry/spice-like items (salt/pepper/spices) by default.
class ShoppingIngredientFormatter {
  const ShoppingIngredientFormatter({IngredientNormalizer? normalizer})
      : _normalizer = normalizer ?? const IngredientNormalizer();

  final IngredientNormalizer _normalizer;

  static const Set<String> _stopTokens = {
    // prep/form
    'rendelenmiş',
    'rendesi',
    'rende',
    'doğranmış',
    'ince',
    'küçük',
    'büyük',
    'orta',
    'boy',
    'iri',
    'taze',
    'kuru',
    'haşlanmış',
    'kavrulmuş',
    'çekilmiş',
    'toz',
    'eritilmiş',
    'sıcak',
    'soğuk',
    'süzme',
    'dilim',
    'dilimlenmiş',
    'küp',
    'ezilmiş',
    'dövülmüş',
    'parça',
    'yaprak',
    'ayıklanmış',
    'temizlenmiş',
    // common connective leftovers
    've',
    'ile',
  };

  static const Set<String> _spiceSeeds = {
    'tuz',
    'karabiber',
    'kimyon',
    'pul biber',
    'kabartma tozu',
    'toz kırmızı biber',
    'kekik',
    'vanilin',
    'nane',
    'kuru nane',
    'tarçın',
    'yenibahar',
    'susam',
    'karbonat',
    'sumak',
    'muskat',
    'zerdeçal',
    'zencefil',
    'karanfil',
  };

  bool isPantryOrSpice(String ingredientName) {
    final n = _normalize(ingredientName);
    if (n.isEmpty) return false;
    // exact-ish matches for multiword spices
    for (final s in _spiceSeeds) {
      if (n == _normalize(s)) return true;
    }
    // token-based fallback
    final toks = n.split(' ').where((t) => t.trim().isNotEmpty).toList(growable: false);
    if (toks.isEmpty) return false;
    const common = {'tuz', 'karabiber', 'kimyon', 'kekik', 'nane', 'susam', 'vanilin', 'muskat', 'sumak', 'tarçın', 'karbonat', 'kabartma'};
    return toks.any(common.contains);
  }

  /// Returns a shopping-friendly name.
  ///
  /// When [includePantryOrSpice] is false (default), pantry/spice-like items
  /// return `null` so the caller can skip them.
  String? toShoppingName(
    String ingredientName, {
    bool includePantryOrSpice = false,
  }) {
    final raw = ingredientName.trim();
    if (raw.isEmpty) return null;

    if (!includePantryOrSpice && isPantryOrSpice(raw)) return null;

    // Work on a normalized token stream but preserve original casing by returning the
    // normalized (lower) output. Shopping list is already lowercased in dataset.
    final tokens = _normalize(raw).split(' ').where((t) => t.trim().isNotEmpty).toList();
    if (tokens.isEmpty) return raw;

    final kept = <String>[];
    for (final t in tokens) {
      if (_stopTokens.contains(t)) continue;
      kept.add(t);
    }
    final out = kept.join(' ').trim();
    if (out.isEmpty) return raw;
    return out;
  }

  String _normalize(String s) => _normalizer.normalize(s);
}

