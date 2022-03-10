import 'package:achievement_tracker/routes/routes_beamer.dart';
import 'package:achievement_tracker/utils/riverpod_utils.dart';
import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

void main() async {
  _setUpLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
        Locale('en', 'US'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(
        observers: [
          if (kDebugMode) ProviderLogger(),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerDelegate: BeamerRoutes.delegator,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: BeamerRoutes.delegator),
    );
  }
}

/// Инициализация настроек логгера
void _setUpLogging() {
  // В сборках профилирования и релизе вывод только сообщений об ошибках/угрозах и т.п.
  if (kReleaseMode || kProfileMode) {
    Logger.root.level = Level.WARNING;
  } else if (kDebugMode) {
    Logger.root.level = Level.FINE; // defaults to Level.INFO
  }
  // Настройка логгера. Просто выводит в консоль сообщение в определенном формате
  Logger.root.onRecord.listen((log) {
    // ignore: avoid_print
    print('[${log.level.name}] ${log.loggerName} \t ${log.time} \t ${log.message}');
  });
}
