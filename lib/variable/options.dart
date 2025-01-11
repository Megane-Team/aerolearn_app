class Options {
  final int id;
  final int idQuestion;
  final String jawaban;

  Options({
    required this.id,
    required this.idQuestion,
    required this.jawaban,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      idQuestion: json['id_question'],
      jawaban: json['jawaban'],
    );
  }
}
