class RecipeUserRating {
  final int rating; // 1..5
  final String comment;

  const RecipeUserRating({
    required this.rating,
    required this.comment,
  });

  factory RecipeUserRating.fromJson(Map<String, Object?> json) {
    return RecipeUserRating(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: (json['comment'] as String?) ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return {
      'rating': rating,
      'comment': comment,
    };
  }
}

