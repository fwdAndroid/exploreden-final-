class Review {
  final String authorName;
  final String text;
  final double rating;

  Review({required this.authorName, required this.text, required this.rating});

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      authorName: map['author_name'] ?? '',
      text: map['text'] ?? '',
      rating: map['rating'] != null ? map['rating'].toDouble() : 0.0,
    );
  }
}
