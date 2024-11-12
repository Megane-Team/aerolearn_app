import 'package:aerolearn/page/progress.dart';
import 'package:aerolearn/page/schedule.dart';
import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';
import 'package:aerolearn/page/beranda.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(path: "/profile", builder: (context, state) => const Profile()),
    GoRoute(
        path: "/notification",
        builder: (context, state) => const Notification()),
    GoRoute(path: "/schedule", builder: (context, state) => const Schedule()),
    GoRoute(path: "/progress", builder: (context, state) => const Progress()),
    GoRoute(path: '/history', builder: (context, state) => const History()),
    GoRoute(path: "/", builder: (context, state) => const Beranda()),
  ],
);
