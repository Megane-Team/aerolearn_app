// ignore_for_file: non_constant_identifier_names

import 'package:aerolearn/page/sub_page/notification.dart';
import 'package:aerolearn/page/sub_page/profile.dart';
import 'package:aerolearn/page/sub_page/training_history.dart';
import 'package:aerolearn/utils/navigation_bar.dart';
import 'package:aerolearn/utils/session.dart';
import 'package:go_router/go_router.dart';
import 'package:aerolearn/page/login.dart';
import 'package:aerolearn/page/sub_page/detail.dart';
import 'package:aerolearn/page/sub_page/materi.dart';
import 'package:aerolearn/page/sub_page/katalog_training.dart';

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
            path: "/materi",
            pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: Materi(
                      id: state.uri.queryParameters['id'],
                      konten: state.extra as String),
                )),
        GoRoute(
          path: "/katalog",
          pageBuilder: (context, state) {
            final id = state.uri.queryParameters['id'];
            final extraData = state.extra as Map<String, dynamic>;
            final instruktur = extraData['instruktur'];
            final training = extraData['training'];
            final id_pelatihan = extraData['id_pelatihan'];
            return NoTransitionPage(
              key: state.pageKey,
              child: KatalogTraining(
                  id: id,
                  instruktur: instruktur,
                  training: training,
                  id_pelatihan: id_pelatihan),
            );
          },
        ),
      ],
    );
  }
}
