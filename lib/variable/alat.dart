class Alat {
  final int id;
  final String nama;
  final String createdAt;

  Alat({
    required this.id,
    required this.nama,
    required this.createdAt,
  });

  factory Alat.fromJson(Map<String, dynamic> json) {
    return Alat(
      id: json['id'],
      nama: json['nama'],
      createdAt: json['createdAt'],
    );
  }
}
