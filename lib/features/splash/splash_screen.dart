import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/injection/injection_container.dart';
import '../../core/network/internet_checker.dart';
import '../../core/router/app_router.dart';
import '../user/data/models/user_model.dart';
import '../user/presentation/logic/bloc/user_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  bool isExist = false;

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  void _onBoxChange() {
    if (mounted) {
      setState(() {
        getUserData();
      });
    }
  }

  bool isUserExist() {
    if (userBox.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    sl<InternetChecker>().run();
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
    isExist = isUserExist();
    Future.delayed(const Duration(seconds: 3), () async {
      checkUserBoxAndNavigate();
    });
  }

  Future<void> checkUserBoxAndNavigate() async {
    if (isExist) {
      final userBloc = sl<UserBloc>();
      // Add an event to load user data
      await userBloc
        ..add(GetUserEvent(user!.id!));

      // Wait for the loading to complete
      await userBloc.stream
          .firstWhere((state) => state is UserLoaded || state is UserError);

      log("user!.events.toString()");
      log(user!.events.toString());
      await context.router.popAndPush(const HomeRoute());
    } else {
      await context.router.popAndPush(const LanguagesRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 5)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const Text('internet connection check done');
              }
              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  LoadingAnimationWidget.dotsTriangle(
                    color: Theme.of(context).primaryColorDark,
                    size: 75,
                  ),
                  LoadingAnimationWidget.flickr(
                    leftDotColor: Theme.of(context).colorScheme.secondary,
                    rightDotColor: Theme.of(context).primaryColorDark,
                    size: 75,
                  ),
                ],
              );
            }));
  }
}
