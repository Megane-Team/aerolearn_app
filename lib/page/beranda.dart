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
          preferredSize: const Size.fromHeight(212.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
            child: AppBar(
              backgroundColor: const Color(0xFF12395D),
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: Color(0xffDADADA),
                          child: Icon(Icons.person,
                              size: 29, color: Color(0xff12395D)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF09B1EC)),
                            ),
                            Text(
                              'Selamat siang!',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: training.length,
            itemBuilder: (context, index) {
              var detailTraining = training[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 95,
                    decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pelatihan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              detailTraining['jenis_latihan']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Rincian'),
                        ),
                      ],
                    )),
              );
            },
          ))
        ],
      ),
    );
  }
}

List<Map<String, String>> training = [
  {'jenis_latihan': 'Aircraft Painting'},
  {'jenis_latihan': 'Aircraft Modification'},
  {'jenis_latihan': 'Aircraft Painting'},
  {'jenis_latihan': 'Aircraft Modification'},
  {'jenis_latihan': 'Aircraft Painting'},
  {'jenis_latihan': 'Aircraft Modification'},
  {'jenis_latihan': 'Aircraft Painting'},
  {'jenis_latihan': 'Aircraft Modification'},
];
