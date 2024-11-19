class UserProfile {
  final int id;
  final String username;
  final String nik;
  final String nama;
  final String password;
  final String email;
  final String user_role;

  UserProfile(
      {required this.id,
      required this.username,
      required this.nik,
      required this.email,
      required this.nama,
      required this.password,
      required this.user_role});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      nik: json['nik'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
      user_role: json['user_role'],
    );
  }
}
