import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/Login", builder: (context, state) => const Login()),
    GoRoute(path: "/", builder: (context, state) => const Profile()),
  ],
);
