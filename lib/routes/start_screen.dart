import 'package:achievement_tracker/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// Начальный экран, если это первый запуск приложения пользователем,
/// то появляется onboarding_screen, а после окно логина. Если это уже не первый запуск,
/// то открывается основное окно приложения
class StartScreen extends ConsumerWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(_isFirstLaunch).when(
            data: (isFirstLaunch) => Center(
              child: isFirstLaunch ? const Text('first_launch') : const Text('non_first_launch'),
            ),
            error: (error, stackTrace) {
              log.e('first launch error', error, stackTrace);
              return Center(child: Text('$error'));
            },
            loading: () => const Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
    );
  }
}

/// Riverpod с проверкой, первый ли это запуск приложения
final _isFirstLaunch = FutureProvider<bool>((ref) async {
  final box = await Hive.openBox<bool>('launch');
  final isFirstLaunch = box.get('fist_launch', defaultValue: true)!;
  if (isFirstLaunch) box.put('fist_launch', false);
  return isFirstLaunch;
});
