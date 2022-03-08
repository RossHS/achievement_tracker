import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

/// Экран с ошибкой 404, когда в качестве аргумента
/// использован некорректный маршрут
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: theme.textTheme.headline1,
            ),
            // TODO 08.03.2022 - перевод
            const Text('Pge Not Found'),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Beamer.of(context).beamToReplacementNamed('/');
              },
              icon: const Icon(Icons.home),
              // TODO 08.03.2022 - перевод
              label: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
