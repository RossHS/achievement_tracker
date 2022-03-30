import 'dart:io';

import 'package:achievement_tracker/routes/routes_beamer.dart';
import 'package:achievement_tracker/utils/riverpod_utils.dart';
import 'package:achievement_tracker/widgets/app_init.dart';
import 'package:achievement_tracker/widgets/restart_widget.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Из-за fullscreen splash screen на iOS надо руками восстанавливать статус бар и navigation бар
  // https://pub.dev/packages/flutter_native_splash
  if (!kIsWeb && Platform.isIOS) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
  }

  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(
    RestartWidget(
      child: ProviderScope(
        observers: const [
          if (kDebugMode) RiverpodLogger(),
        ],
        child: AppInit(
          initList: [
            FutureWrapper(futureCallback: () => testCall(5)),
            FutureWrapper(futureCallback: () => testCall(6)),
            FutureWrapper(futureCallback: () => testCall(7)),
            FutureWrapper(futureCallback: () => testCall(8)),
          ],
          afterInitCallback: () {
            // По завершению инициализации отключаем SplashScreen, использую future,
            // чтобы пропустить фрейм создания [MyApp] и как следствие избежать
            // кратковременного "мигания" экрана
            Future(FlutterNativeSplash.remove);
          },
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: BeamerRoutes.delegator,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: BeamerRoutes.delegator),
    );
  }
}

Future<void> testCall(int sec) async {
  await Future.delayed(Duration(seconds: sec));
  print('Complete $sec');
}
