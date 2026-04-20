class InventoryItem {
  final String id;
  final String name;
  final String emoji;
  final int quantity;
  final String unit;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.quantity,
    this.unit = 'adet',
  });

  InventoryItem copyWith({
    String? id,
    String? name,
    String? emoji,
    int? quantity,
    String? unit,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
