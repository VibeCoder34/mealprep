enum UnitGroup { count, weight, volume, other }

class UnitSystem {
  const UnitSystem();

  UnitGroup groupOf(String unitRaw) {
    final u = unitRaw.trim().toLowerCase();
    if (u.isEmpty) return UnitGroup.other;
    if (u == 'pcs' || u == 'adet' || u == 'piece' || u == 'pieces') return UnitGroup.count;
    if (u == 'g' || u == 'gram' || u == 'gr' || u == 'kg') return UnitGroup.weight;
    if (u == 'ml' || u == 'l' || u == 'litre' || u == 'liter') return UnitGroup.volume;
    return UnitGroup.other;
  }

  String groupKey(UnitGroup g) {
    switch (g) {
      case UnitGroup.count:
        return 'count';
      case UnitGroup.weight:
        return 'weight';
      case UnitGroup.volume:
        return 'volume';
      case UnitGroup.other:
        return 'other';
    }
  }

  /// Converts [qty] from [fromUnit] into [toUnit] when both are in the same group.
  /// Returns null if not convertible.
  num? convert(num qty, {required String fromUnit, required String toUnit}) {
    final from = fromUnit.trim();
    final to = toUnit.trim();
    if (from.isEmpty || to.isEmpty) return null;
    if (from.toLowerCase() == to.toLowerCase()) return qty;

    final gf = groupOf(from);
    final gt = groupOf(to);
    if (gf != gt) return null;

    if (gf == UnitGroup.weight) {
      final f = from.toLowerCase();
      final t = to.toLowerCase();
      if (f == 'kg' && (t == 'g' || t == 'gram' || t == 'gr')) return qty * 1000;
      if ((f == 'g' || f == 'gram' || f == 'gr') && t == 'kg') return qty / 1000;
      return null;
    }

    if (gf == UnitGroup.volume) {
      final f = from.toLowerCase();
      final t = to.toLowerCase();
      if (f == 'l' && t == 'ml') return qty * 1000;
      if (f == 'ml' && t == 'l') return qty / 1000;
      if (f == 'litre' && t == 'ml') return qty * 1000;
      if (f == 'liter' && t == 'ml') return qty * 1000;
      if (f == 'ml' && (t == 'litre' || t == 'liter' || t == 'l')) return qty / 1000;
      return null;
    }

    if (gf == UnitGroup.count) {
      // count units are treated as identical (no scale).
      return qty;
    }

    return null;
  }
}

