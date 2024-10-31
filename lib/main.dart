import 'package:flutter/material.dart';
import 'package:aerolearn/router.dart';
import 'package:aerolearn/constant/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      routerConfig: router,
    );
  }
}
