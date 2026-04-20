import 'shopping_item.dart';

/// A named shopping list (user-created) with optional description.
class ShoppingListBundle {
  final String id;
  final String name;
  final String description;
  final List<ShoppingItem> items;

  const ShoppingListBundle({
    required this.id,
    required this.name,
    this.description = '',
    this.items = const [],
  });

  factory ShoppingListBundle.fromJson(Map<String, Object?> json) {
    final itemsJson = json['items'];
    final decodedItems = (itemsJson is List)
        ? itemsJson
            .whereType<Map>()
            .map((m) => Map<String, Object?>.from(m))
            .map(ShoppingItem.fromJson)
            .toList(growable: false)
        : const <ShoppingItem>[];
    return ShoppingListBundle(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '—',
      description: (json['description'] as String?) ?? '',
      items: decodedItems,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'items': items.map((i) => i.toJson()).toList(growable: false),
    };
  }

  ShoppingListBundle copyWith({
    String? name,
    String? description,
    List<ShoppingItem>? items,
  }) {
    return ShoppingListBundle(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      items: items ?? this.items,
    );
  }

  int get itemCount => items.length;

  int get boughtCount => items.where((i) => i.isBought).length;
}
