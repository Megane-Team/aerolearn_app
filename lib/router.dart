import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:aerolearn/utils/navigation_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';

final router = GoRouter(
  initialLocation: ('/mainpage'),
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
  ],
);
