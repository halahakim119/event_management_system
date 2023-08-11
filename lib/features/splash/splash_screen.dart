import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  late Box<UserProfileModel> userBox;
  bool isExist = false;

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      isExist = isUserExist();
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
    initUserBox();
    Future.delayed(const Duration(seconds: 3), () async {
      checkUserBoxAndNavigate();
    });
  }

  Future<void> checkUserBoxAndNavigate() async {
    if (isExist) {
      await context.router.popAndPush(const HomeRoute());
    } else {
      await context.router.popAndPush(const LanguagesRoute());
    }
  }

  void initUserBox() async {
    if (Hive.isBoxOpen('userbox')) {
      userBox = Hive.box('userbox');
    } else {
      userBox = await Hive.openBox('userbox');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('splash screen'),
      ),
    );
  }
}
