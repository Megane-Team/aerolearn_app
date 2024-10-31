import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => const Login()),
  ],
);
