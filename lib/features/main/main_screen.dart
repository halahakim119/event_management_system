import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../core/router/app_router.dart';
import '../theme/presentation/theme_cubit.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _showButtonContainer = false;
  late AnimationController controller;
  late Animation<Color?> animation;
  IconData _floatingActionButtonIcon = Icons.settings;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _toggleButtonContainer() {
    if (controller.isCompleted || controller.isAnimating) {
      controller.reverse();
      _floatingActionButtonIcon = Icons.settings;
    } else {
      controller.forward();
      _floatingActionButtonIcon = Icons.settings;
    }

    setState(() {
      _showButtonContainer = !_showButtonContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), ProfileRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            splashColor: Theme.of(context).primaryColorDark,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _toggleButtonContainer,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(controller),
              child: Icon(
                _floatingActionButtonIcon,
                color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) => tabsRouter.setActiveIndex(index),
            color: Theme.of(context).colorScheme.onInverseSurface,
            animationDuration: const Duration(milliseconds: 250),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            index: tabsRouter.activeIndex,
            animationCurve: Curves.ease,
            items: const [
              Icon(
                Icons.home,
              ),
              Icon(
                Icons.person,
              ),
            ],
          ),
          body: Stack(
            children: [
              child,
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: _showButtonContainer,
                  child: WidgetAnimator(
                    incomingEffect: WidgetTransitionEffects.outgoingScaleDown(
                        duration: const Duration(milliseconds: 500)),
                    child: BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, state) {
                        return Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton(
                                  onPressed: () {
                                    context.router.push(const SettingsRoute());
                                  },
                                  child: const Text(
                                    'settings',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
