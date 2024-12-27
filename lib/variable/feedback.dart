// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

class feedback {
  final int id;
  final String text;
  final String createdAt;

  feedback({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory feedback.fromJson(Map<String, dynamic> json) {
    return feedback(
      id: json['id'],
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }
}
