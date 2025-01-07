class Feedback {
  final int id;
  final String text;
  final String createdAt;

  Feedback({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }
}
