import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(214.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
            child: AppBar(
              backgroundColor: const Color(0xFF12395D),
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    const Row(
                      children: [
                        const CircleAvatar(
                          radius: 23,
                          backgroundColor: Color(0xffDADADA),
                          child: Icon(Icons.person,
                              size: 29, color: Color(0xff12395D)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF09B1EC)),
                            ),
                            const Text(
                              'Selamat siang!',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 5),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari Pelatihan',
                              hintStyle: TextStyle(
                                color: Color(0xFF12395D),
                              ),
                              border: InputBorder.none,
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
