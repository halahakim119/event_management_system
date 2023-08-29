import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../translations/locale_keys.g.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.5, // Adjust the width as needed
              child: Image.asset(
                  'assets/images/login.png'), // Replace with your image asset path
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.router.push(const AuthRoute());
              },
              child: Text(LocaleKeys.Login.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
