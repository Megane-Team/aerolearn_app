class Question {
  final int id;
  final String question;
  final String gambar;
  final int idExam;

  Question({
    required this.id,
    required this.question,
    required this.gambar,
    required this.idExam,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      gambar: json['gambar'],
      idExam: json['id_exam'],
    );
  }
}
