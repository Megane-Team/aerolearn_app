class Esertifikat {
  final int id;
  final String idPeserta;
  final String idPelatihan;
  final String sertifikasi;
  final String createdAt;

  Esertifikat({
    required this.id,
    required this.idPeserta,
    required this.idPelatihan,
    required this.sertifikasi,
    required this.createdAt,
  });

  factory Esertifikat.fromJson(Map<String, dynamic> json) {
    return Esertifikat(
      id: json['id'],
      idPeserta: json['id_peserta'],
      idPelatihan: json['id_pelatihan'],
      sertifikasi: json['sertifikasi'],
      createdAt: json['createdAt'],
    );
  }
}
