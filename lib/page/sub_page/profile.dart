import 'package:flutter/material.dart';
import 'package:aerolearn/action/profile.dart';
import 'package:aerolearn/page/sub_page/sertifikat_list.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/variable/profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(175.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff12395D),
            elevation: 0,
            title: Row(
              children: [
                IconButton(
                  icon:
                  const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Kembali',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            flexibleSpace: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 3,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xffDADADA),
                  child: Icon(Icons.person, size: 70, color: Color(0xff12395D)),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<UserProfile?>(
                  future: fetchUserProfile(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          buildNonEditableField('E-mail', snapshot.data!.email),
                          buildNonEditableField('Nama', snapshot.data!.nama),
                          buildNonEditableField('No Telp',
                              snapshot.data?.noTelp ?? 'tidak ada nomer telepon'),
                          buildNonEditableField('Tempat, Tanggal Lahir',
                              '${snapshot.data!.tempatLahir}, ${snapshot.data!.tanggalLahir}')
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          buildNonEditableField('E-mail', ''),
                          buildNonEditableField('Nama', ''),
                          buildNonEditableField('No Telp', ''),
                          buildNonEditableField('Tempat, Tanggal Lahir', '')
                        ],
                      );
                    }
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButtonRow('E-Sertifikat', Icons.chevron_right, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SertifikatList()),
                    );
                  }),
                  buildButtonRow('Riwayat Pelatihan', Icons.chevron_right, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => History()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff12395D).withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 0), // Offset in x and y direction
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            minimumSize: const Size(100, 40),
                          ),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await SessionService.logout();
                            context.go('/login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: const BorderSide(color: Colors.green),
                            minimumSize: const Size(100, 40),
                          ),
                          child: const Text('Ya'),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: Color(0xff12395D)),
              SizedBox(width: 10),
              Text(
                'Keluar',
                style: TextStyle(
                  color: Color(0xff12395D),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNonEditableField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildButtonRow(String text, IconData icon, VoidCallback onPressed,
    {Color? backgroundColor}) {
  return Container(
    color: backgroundColor,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            color: Color(0xff12395D),
          ),
          SizedBox(width: 8), // Add some space between the line and text
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Icon(icon, color: const Color(0xff12395D)),
        ],
      ),
    ),
  );
}