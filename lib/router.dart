// ignore_for_file: non_constant_identifier_names

import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:aerolearn/utils/navigation_bar.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';
import 'package:aerolearn/page/sub_page/detail.dart';

final getToken = SessionService.getToken();
late String initialLocation;

class AppRouter {
  static Future<GoRouter> createRouter() async {
    final token = await SessionService.getToken();
    initialLocation = token != null ? '/mainpage' : '/login';

    return GoRouter(
      initialLocation: (initialLocation),
      routes: [
        GoRoute(
          path: "/login",
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const Login(),
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
      ],
    );
  }
}
