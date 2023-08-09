import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_system/core/router/app_router.dart';
import 'package:event_management_system/features/authentication/presentation/view/pages/signup_screen.dart';
import '../../../../../translations/locale_keys.g.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedIndex = 0;

  Widget buildButton(int index, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: selectedIndex == index
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: TextButton(
          child: Text(
            label,
            style: TextStyle(
              color: selectedIndex == index
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
          onPressed: () {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const HomeRoute());
        },
        child: const Icon(Icons.home_filled),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            if (selectedIndex == 0)
              const CircleAvatar(backgroundColor: Colors.teal, radius: 80),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: -10, // Spread radius
                    blurRadius: 10, // Blur radius
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton(0, LocaleKeys.Login.tr()),
                  buildButton(1, LocaleKeys.Sign_Up.tr()),
                ],
              ),
            ),
            if (selectedIndex == 0)
              const Expanded(
                child: LoginScreen(),
              ),
            if (selectedIndex == 1)
              const Expanded(
                child: SignupScreen(),
              ),
          ]),
    );
  }
}
