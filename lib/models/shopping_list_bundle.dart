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
