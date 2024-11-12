import 'package:flutter/material.dart';
import 'package:aerolearn/utils/greetings.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/utils/search.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTraining = filterTraining(training, searchQuery);
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
              title: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.go('/profile');
                      },
                      child: const CircleAvatar(
                        radius: 23,
                        backgroundColor: Color(0xffDADADA),
                        child: Icon(
                          Icons.person,
                          size: 29,
                          color: Color(0xff12395D),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, ',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF09B1EC)),
                        ),
                        Text(
                          getGreeting(),
                          style: const TextStyle(
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
              ),
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  Container(
                    width: 360,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child:TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Color(0xff12395D)),
                        hintText: 'Cari Pelatihan',
                        hintStyle: TextStyle(
                          color: Color(0xff12395D),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          )),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: filteredTraining.length,
            itemBuilder: (context, index) {
              var detailTraining = filteredTraining[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
