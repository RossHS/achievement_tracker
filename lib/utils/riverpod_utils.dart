import 'package:achievement_tracker/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Логгер для захвата изменений в состояниях riverpod`а
class RiverpodLogger extends ProviderObserver {
  const RiverpodLogger();

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.d('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}
