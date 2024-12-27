// ignore_for_file: non_constant_identifier_names

class PelaksanaPelatihan {
  final int id;
  final int id_pelatihan;
  final String nama_pelatihan;
  final String nama_instruktur;
  final DateTime tanggal_mulai;
  final DateTime tanggal_selesai;
  final String jam_mulai;
  final String jam_selesai;
  final String jenis_training;
  final String isSelesai;
  final String ruangan;

  PelaksanaPelatihan({
    required this.id,
    required this.id_pelatihan,
    required this.nama_pelatihan,
    required this.nama_instruktur,
    required this.tanggal_mulai,
    required this.tanggal_selesai,
    required this.jam_mulai,
    required this.jam_selesai,
    required this.jenis_training,
    required this.isSelesai,
    required this.ruangan,
  });

  factory PelaksanaPelatihan.fromJson(Map<String, dynamic> json) {
    return PelaksanaPelatihan(
      id: json['id'],
      id_pelatihan: json['id_pelatihan'],
      nama_pelatihan: json['nama_pelatihan'],
      nama_instruktur: json['nama_instruktur'],
      tanggal_mulai: DateTime.parse(json['tanggal_mulai']),
      tanggal_selesai: DateTime.parse(json['tanggal_selesai']),
      jam_selesai: json['jamMulai'],
      jam_mulai: json['jamSelesai'],
      jenis_training: json['jenis_training'],
      isSelesai: json['isSelesai'],
      ruangan: json['ruangan'],
    );
  }
}
