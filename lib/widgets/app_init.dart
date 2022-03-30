import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Виджет, в котором создается и используется [_preInitRiverpod], который инициализирует необходимые данные.
/// Основным преимуществом является возможность оповестить пользователя о текущем статусе загрузки
/// и потенциальных ошибках и проблемах, таким образом устраняется (в случае ошибки) бесконечный splashScreen,
/// а у пользователя появляется обратная связь.
class AppInit extends ConsumerWidget {
  const AppInit({
    Key? key,
    required this.child,
    required this.initList,
    this.afterInitCallback,
  }) : super(key: key);

  final Widget child;
  final List<FutureWrapper> initList;
  final VoidCallback? afterInitCallback;

  @override
  Widget build(BuildContext context, ref) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ref.watch(_preInitRiverpod(initList)).when(
            data: (data) {
              print('completed');
              return child;
            },
            error: (e, s) => Text('$e,$s'),
            loading: () {
              print('loading');
              return const CircularProgressIndicator();
            },
          ),
    );
  }
}

final _preInitRiverpod = FutureProvider.family<void, List<FutureWrapper>>(
  (ref, args) {
    return PreInitList(args).init();
  },
  name: 'PreInitRiverpod',
);

class PreInitList extends StateNotifier<AsyncValue> {
  PreInitList(this._initList) : super(const AsyncLoading());

  final List<FutureWrapper> _initList;

  Future<void> init() async {
    // TODO описать работу с прединициализацией
    state = const AsyncLoading();
    await Future.wait(_initList.map((e) => e.futureCallback()));
    state = const AsyncData(true);
  }
}

class FutureWrapper<T> {
  FutureWrapper({
    required this.futureCallback,
  });

  final Future<T> Function() futureCallback;
}
