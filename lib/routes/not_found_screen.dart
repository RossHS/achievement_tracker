import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
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
            Text(tr('404.page_not_found')),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Beamer.of(context).beamToReplacementNamed('/');
              },
              icon: const Icon(Icons.home),
              label: Text(tr('404.to_home')),
            ),
          ],
        ),
      ),
    );
  }
}
