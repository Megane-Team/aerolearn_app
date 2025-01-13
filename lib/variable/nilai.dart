class Nilai {
  final int id;
  final int idPeserta;
  final int idPelaksanaanPelatihan;
  final String score;
  final String createdAt;

  Nilai({
    required this.id,
    required this.idPeserta,
    required this.idPelaksanaanPelatihan,
    required this.score,
    required this.createdAt,
  });

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      id: json['id'],
      idPeserta: json['id_peserta'],
      idPelaksanaanPelatihan: json['id_pelaksanaan_pelatihan'],
      score: json['score'],
      createdAt: json['createdAt'],
    );
  }
}
