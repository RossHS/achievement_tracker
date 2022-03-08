import 'package:achievement_tracker/routes/home_screen.dart';
import 'package:achievement_tracker/routes/not_found_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

/// Все возможные маршруты приложения для библиотеки [Beamer]
class BeamerRoutes {
  BeamerRoutes._();

  static final delegator = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomeScreen(),
      },
    ),
    notFoundPage: const BeamPage(
      key: ValueKey('not-found'),
      title: '404',
      child: NotFoundScreen(),
    ),
  );
}
