import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() async {
  _setUpLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
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
