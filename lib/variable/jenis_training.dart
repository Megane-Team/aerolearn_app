class Training {
  final int id;
  final String nama;
  final String deskripsi;
  final String koordinator;
  final String kategori;

  Training({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.koordinator,
    required this.kategori,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      koordinator: json['koordinator'],
      kategori: json['kategori'],
    );
  }
}
