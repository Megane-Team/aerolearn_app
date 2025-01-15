class Notifications {
  final int id;
  final int idUser;
  final String title;
  final String detail;
  final DateTime tanggal;
  final int idPelaksanaanPelatihan;
  final String createdAt;

  Notifications({
    required this.id,
    required this.idUser,
    required this.title,
    required this.detail,
    required this.tanggal,
    required this.idPelaksanaanPelatihan,
    required this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      idUser: json['id_user'],
      title: json['title'],
      detail: json['detail'],
      tanggal: DateTime.parse(json['tanggal']),
      idPelaksanaanPelatihan: json['id_pelaksanaan_pelatihan'],
      createdAt: json['createdAt'],
    );
  }
}
