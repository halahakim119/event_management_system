import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/injection/injection_container.dart';
import '../../core/network/internet_checker.dart';
import '../../core/router/app_router.dart';
import '../profile/data/models/user_profile_model.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserProfileModel? user;
  final userBox = Hive.box<UserProfileModel>('userBox');

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
    setState(() {
      getUserData();
    });
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
      // sl<UserBloc>().add(GetUserEvent(user!.id));
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
