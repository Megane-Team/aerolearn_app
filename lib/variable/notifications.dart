// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

class Notifications {
  final int id;
  final int id_peserta;
  final String title;
  final String detail;
  final DateTime tanggal;
  final int id_pelaksanaan_pelatihan;
  final String createdAt;

  Notifications({
    required this.id,
    required this.id_peserta,
    required this.title,
    required this.detail,
    required this.tanggal,
    required this.id_pelaksanaan_pelatihan,
    required this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      id_peserta: json['id_peserta'],
      title: json['title'],
      detail: json['title'],
      tanggal: DateTime.parse(json['tanggal']),
      id_pelaksanaan_pelatihan: json['id_pelaksanaan_pelatihan'],
      createdAt: json['createdAt'],
    );
  }
}
