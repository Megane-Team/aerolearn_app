// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

class eSertifikat {
  final int id;
  final String id_peserta;
  final String id_pelatihan;
  final String sertifikasi;
  final String createdAt;

  eSertifikat({
    required this.id,
    required this.id_peserta,
    required this.id_pelatihan,
    required this.sertifikasi,
    required this.createdAt,
  });

  factory eSertifikat.fromJson(Map<String, dynamic> json) {
    return eSertifikat(
      id: json['id'],
      id_peserta: json['id_peserta'],
      id_pelatihan: json['id_pelatihan'],
      sertifikasi: json['sertifikasi'],
      createdAt: json['createdAt'],
    );
  }
}
