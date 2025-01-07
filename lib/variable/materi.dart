class Materi {
  final int id;
  final String judul;
  final String konten;
  final int idPelatihan;

  Materi({
    required this.id,
    required this.judul,
    required this.konten,
    required this.idPelatihan,
  });

  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      id: json['id'],
      judul: json['judul'],
      konten: json['konten'],
      idPelatihan: json['id_pelatihan'],
    );
  }
}
