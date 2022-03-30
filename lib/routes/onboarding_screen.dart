import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Окно приветствия нового пользователя, которое знакомит с основным
/// функционалом и предназначением приложения
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(
        children: [
          Container(color: Colors.white),
          Container(color: Colors.greenAccent),
          Container(color: Colors.blueGrey),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final PageController _pageController;
  late final ValueNotifier<int> _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = ValueNotifier(_pageController.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    print('rebuild!');
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: _Carousel(
            onPageChanged: (page) {
              _currentPage.value = page;
            },
            pageController: _pageController,
            children: widget.children,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    print('skip');
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text(tr.onboardingSkip),
                ),
              ),
              RepaintBoundary(
                child: ValueListenableBuilder(
                  valueListenable: _currentPage,
                  builder: (context, value, child) => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (var i = 0; i < widget.children.length; i++)
                        AnimatedContainer(
                          key: ValueKey(i),
                          duration: const Duration(milliseconds: 300),
                          height: 10,
                          width: i == value ? 30 : 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: i == value ? colorScheme.primary : Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    print(_pageController.page);
                    // Закрытие окна приветствия пользователя, если это последний блок информации
                    if (_pageController.page == widget.children.length - 1) {
                      print('end!');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  child: Text(tr.onboardingNext),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    Key? key,
    required this.children,
    this.pageController,
    this.onPageChanged,
  }) : super(key: key);

  final List<Widget> children;
  final PageController? pageController;
  final Function(int page)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      controller: pageController,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}
