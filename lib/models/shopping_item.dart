class ShoppingItem {
  final String id;
  final String name;
  final String amount;
  /// Recipe id (e.g. r1), `general` for miscellaneous, or `manual` for user-added rows.
  final String recipeId;
  final bool isBought;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.recipeId,
    this.isBought = false,
  });

  ShoppingItem copyWith({bool? isBought}) {
    return ShoppingItem(
      id: id,
      name: name,
      amount: amount,
      recipeId: recipeId,
      isBought: isBought ?? this.isBought,
    );
  }
}
