class ShoppingItem {
  final String id;
  final String name;
  final String amount;
  /// Recipe id (e.g. r1), `general` for miscellaneous, or `manual` for user-added rows.
  final String recipeId;
  final String? recipeName;
  final bool isBought;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.recipeId,
    this.recipeName,
    this.isBought = false,
  });

  factory ShoppingItem.fromJson(Map<String, Object?> json) {
    return ShoppingItem(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      amount: (json['amount'] as String?) ?? '',
      recipeId: (json['recipeId'] as String?) ?? 'general',
      recipeName: (json['recipeName'] as String?),
      isBought: (json['isBought'] as bool?) ?? false,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'recipeId': recipeId,
      'recipeName': recipeName,
      'isBought': isBought,
    };
  }

  ShoppingItem copyWith({bool? isBought}) {
    return ShoppingItem(
      id: id,
      name: name,
      amount: amount,
      recipeId: recipeId,
      recipeName: recipeName,
      isBought: isBought ?? this.isBought,
    );
  }
}
