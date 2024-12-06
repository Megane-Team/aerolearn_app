class UserProfile {
  final int id;
  final String nama;
  final String password;
  final String email;
  final String userRole;

  UserProfile(
      {required this.id,
      required this.email,
      required this.nama,
      required this.password,
      required this.userRole});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
      userRole: json['user_role'],
    );
  }
}
