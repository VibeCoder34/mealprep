class InventoryItem {
  final String id;
  final String name;
  final String emoji;
  final int quantity;
  final String unit;
  /// Normalized key used for dedupe/upsert.
  final String? itemKey;
  /// Unit compatibility group: count/weight/volume/other.
  final String? unitGroup;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.quantity,
    this.unit = 'adet',
    this.itemKey,
    this.unitGroup,
  });

  factory InventoryItem.fromJson(Map<String, Object?> json) {
    return InventoryItem(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      emoji: (json['emoji'] as String?) ?? '🍽️',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unit: (json['unit'] as String?) ?? 'adet',
      itemKey: (json['itemKey'] as String?),
      unitGroup: (json['unitGroup'] as String?),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'quantity': quantity,
      'unit': unit,
      if (itemKey != null) 'itemKey': itemKey,
      if (unitGroup != null) 'unitGroup': unitGroup,
    };
  }

  InventoryItem copyWith({
    String? id,
    String? name,
    String? emoji,
    int? quantity,
    String? unit,
    String? itemKey,
    String? unitGroup,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      itemKey: itemKey ?? this.itemKey,
      unitGroup: unitGroup ?? this.unitGroup,
    );
  }
}
