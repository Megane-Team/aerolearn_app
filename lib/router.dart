import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';
import 'package:aerolearn/page/beranda.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/Login", builder: (context, state) => const Login()),
    GoRoute(path: "/test", builder: (context, state) => const Profile()),
    GoRoute(path: "/", builder: (context, state) => const Beranda())
  ],
);
