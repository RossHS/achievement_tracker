import 'package:logger/logger.dart';

/// Стандартный логгер, который следует использовать по всему приложению
final log = Logger(
  printer: PrettyPrinter(
    printTime: true,
    printEmojis: false,
  ),
);
