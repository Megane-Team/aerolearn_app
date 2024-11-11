import 'package:aerolearn/page/progress.dart';
import 'package:aerolearn/page/schedule.dart';
import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(path: "/profile", builder: (context, state) => const Profile()),
    GoRoute(
        path: "/notification",
        builder: (context, state) => const Notification()),
    GoRoute(path: "/schedule", builder: (context, state) => const Schedule()),
    GoRoute(path: "/", builder: (context, state) => const Progress()),
  ],
);
