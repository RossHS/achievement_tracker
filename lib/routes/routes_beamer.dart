import 'package:achievement_tracker/routes/home_screen.dart';
import 'package:beamer/beamer.dart';

/// Все возможные маршруты приложения для библиотеки [Beamer]
class BeamerRoutes {
  BeamerRoutes._();

  static final delegator = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomeScreen(),
      },
    ),
  );
}
