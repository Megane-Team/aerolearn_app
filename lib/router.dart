import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:aerolearn/utils/navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';
import 'package:aerolearn/page/sub_page/detail.dart';
import 'package:aerolearn/page/sub_page/katalog_training.dart';
import 'package:aerolearn/page/sub_page/feedback.dart';
import 'package:aerolearn/page/sub_page/materi.dart';

final router = GoRouter(
  initialLocation: ('/history'),
  routes: [
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Login(),
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: Profile(),
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
      path: "/history",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const History(),
      ),
    ),
    GoRoute(
      path: "/mainpage",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: "/detail",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Detail(),
      ),
    ),
    GoRoute(
      path: "/katalog",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const KatalogTraining(),
      ),
    ),
    GoRoute(
      path: "/materi",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Materi(),
      ),
    ),
    GoRoute(
      path: "/feedback",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const Feedback(),
      ),
    ),
  ],
);
