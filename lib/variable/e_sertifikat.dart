class Esertifikat {
  final int id;
  final int idPeserta;
  final int idPelaksanaanPelatihan;
  final String sertifikasi;
  final String createdAt;

  Esertifikat({
    required this.id,
    required this.idPeserta,
    required this.idPelaksanaanPelatihan,
    required this.sertifikasi,
    required this.createdAt,
  });

  factory Esertifikat.fromJson(Map<String, dynamic> json) {
    return Esertifikat(
      id: json['id'],
      idPeserta: json['id_peserta'],
      idPelaksanaanPelatihan: json['id_pelaksanaan_pelatihan'],
      sertifikasi: json['sertifikasi'],
      createdAt: json['createdAt'],
    );
  }
}
