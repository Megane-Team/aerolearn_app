class Materi {
  final int id;
  final String judul;
  final String konten;
  final int id_pelatihan;

  Materi({
    required this.id,
    required this.judul,
    required this.konten,
    required this.id_pelatihan,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      id: json['id'],
      judul: json['judul'],
      konten: json['konten'],
      id_pelatihan: json['id_pelatihan'],
    );
  }
}
