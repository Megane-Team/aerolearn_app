// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

class nilai {
  final int id;
  final int id_peserta;
  final int id_pelaksanaan_pelatihan;
  final int score;
  final String createdAt;

  nilai({
    required this.id,
    required this.id_peserta,
    required this.id_pelaksanaan_pelatihan,
    required this.score,
    required this.createdAt,
  });

  factory nilai.fromJson(Map<String, dynamic> json) {
    return nilai(
      id: json['id'],
      id_peserta: json['id_peserta'],
      id_pelaksanaan_pelatihan: json['id_pelaksanaan_pelatihan'],
      score: json['score'],
      createdAt: json['createdAt'],
    );
  }
}
