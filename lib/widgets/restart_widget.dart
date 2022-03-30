import 'package:flutter/material.dart';

/// Виджет условной перезагрузки приложения. Работает следующим образом, создается новый уникальный ключ,
/// что приводит в инвалидации дерева виджетов и все дочернее дерево инициализируется по новой.
/// Условной же данный способ перезапуска считается потому-то, не происходит тотального перезапуска
/// всего кода, а только той части, которая относится к деревьям flutter, т.е. весь код написанный до
/// runApp() перезапущен не будет.
class RestartWidget extends StatefulWidget {
  const RestartWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?._restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  var _key = UniqueKey();

  void _restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
