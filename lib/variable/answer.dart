class Jawaban {
  final int id;
  final int idOpsiJawaban;
  final int idPelaksanaanPelatihan;
  final int idQuestion;

  Jawaban({
    required this.id,
    required this.idOpsiJawaban,
    required this.idPelaksanaanPelatihan,
    required this.idQuestion,
  });

  factory Jawaban.fromJson(Map<String, dynamic> json) {
    return Jawaban(
      id: json['id'],
      idOpsiJawaban: json['id_opsi_jawaban'],
      idPelaksanaanPelatihan: json['id_pelaksanaan_pelatihan'],
      idQuestion: json['id_question'],
    );
  }
}
