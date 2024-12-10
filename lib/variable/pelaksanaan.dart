class PelaksanaanPelatihan {
  final int id;
  final String nama_pelatihan;
  final String nama_intsruktur;
  final DateTime tanggal;
  final String jam_mulai;
  final String jam_selesai;
  final String jenis_training;
  final String isSelesai;
  final String ruangan;

  PelaksanaanPelatihan({
    required this.id,
    required this.nama_pelatihan,
    required this.nama_intsruktur,
    required this.tanggal,
    required this.jam_mulai,
    required this.jam_selesai,
    required this.jenis_training,
    required this.isSelesai,
    required this.ruangan,
  });

  factory PelaksanaanPelatihan.fromJson(Map<String, dynamic> json) {
    return PelaksanaanPelatihan(
      id: json['id'],
      nama_pelatihan: json['nama_pelatihan'],
      nama_intsruktur: json['nama_instruktur'],
      tanggal: DateTime.parse(json['tanggal']),
      jam_selesai: json['jamMulai'],
      jam_mulai: json['jamSelesai'],
      jenis_training: json['jenis_training'],
      isSelesai: json['isSelesai'],
      ruangan: json['ruangan'],
    );
  }
}
