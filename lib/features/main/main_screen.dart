import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_management_system/core/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
      
        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  floating: true,
                  snap: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'app name',
                  ),
                  centerTitle: true,
                  actions: [],
                  elevation: 0,
                )
              ];
            },
            body: child,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) => tabsRouter.setActiveIndex(index),
            color: Theme.of(context).colorScheme.primary,
            animationDuration: const Duration(milliseconds: 250),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            index: tabsRouter.activeIndex,
            animationCurve: Curves.ease,
            items: const [
              Icon(
                Icons.home,
              ),
            ],
          ),
        );
      },
    );
  }
}
