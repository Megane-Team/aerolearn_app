class PelaksanaanPelatihan {
  final int id;
  final int idPelatihan;
  final String namaPelatihan;
  final String namaInstruktur;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final String jamMulai;
  final String jamSelesai;
  final String jenisTraining;
  final String isSelesai;
  final String ruangan;

  PelaksanaanPelatihan({
    required this.id,
    required this.idPelatihan,
    required this.namaPelatihan,
    required this.namaInstruktur,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jenisTraining,
    required this.isSelesai,
    required this.ruangan,
  });

  factory PelaksanaanPelatihan.fromJson(Map<String, dynamic> json) {
    return PelaksanaanPelatihan(
      id: json['id'],
      idPelatihan: json['id_pelatihan'],
      namaPelatihan: json['nama_pelatihan'],
      namaInstruktur: json['nama_instruktur'],
      tanggalMulai: DateTime.parse(json['tanggal_mulai']),
      tanggalSelesai: DateTime.parse(json['tanggal_selesai']),
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      jenisTraining: json['jenis_training'],
      isSelesai: json['isSelesai'],
      ruangan: json['ruangan'],
    );
  }
}
