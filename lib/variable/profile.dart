class UserProfile {
  final int id;
  final String nama;
  final String? noTelp;
  final String email;
  final String userRole;
  final String tempatLahir;
  final String tanggalLahir;

  UserProfile(
      {required this.id,
      required this.email,
      required this.nama,
      required this.noTelp,
      required this.userRole,
      required this.tempatLahir,
      required this.tanggalLahir});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      noTelp: json['no_telp'],
      userRole: json['user_role'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'],
    );
  }
}
