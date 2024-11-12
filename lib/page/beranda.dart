import 'package:flutter/material.dart';
import 'package:aerolearn/utils/greetings.dart';
import 'package:go_router/go_router.dart';

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
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Color(0xff12395D)),
                        hintText: 'Cari Pelatihan',
                        hintStyle: TextStyle(
                          color: Color(0xff12395D),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          )),
    );
  }
}
