class Exam {
  final int id;
  final int idPelatihan;

  Exam({
    required this.id,
    required this.idPelatihan,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      idPelatihan: json['id_pelatihan'],
    );
  }
}
