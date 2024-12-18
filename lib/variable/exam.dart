// ignore_for_file: non_constant_identifier_names

class Exam {
  final int id;
  final int id_pelatihan;

  Exam({
    required this.id,
    required this.id_pelatihan,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      id_pelatihan: json['id_pelatihan'],
    );
  }
}
