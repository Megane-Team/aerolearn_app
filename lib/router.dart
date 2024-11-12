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
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Login(),
      ),
    ),
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Profile(),
      ),
    ),
    GoRoute(
      path: "/notification",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const NotificationPage(),
      ),
    ),
    GoRoute(
      path: "/schedule",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Schedule(),
      ),
    ),
    GoRoute(
      path: "/progress",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Progress(),
      ),
    ),
    GoRoute(
      path: "/history",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const History(),
      ),
    ),
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Beranda(),
      ),
    ),
  ],
);
