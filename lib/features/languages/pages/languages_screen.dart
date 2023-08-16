import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_system/core/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../translations/locale_keys.g.dart';

@RoutePage()
class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(LocaleKeys.Welcome.tr(),
                  style: const TextStyle(fontSize: 30)),
              const Spacer(),
              // Text(LocaleKeys.select_your_language.tr()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await context.setLocale(const Locale('ar'));
                      },
                      child: const Text('العربيه'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await context.setLocale(const Locale('en'));
                      },
                      child: const Text('English'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.router.push(const AuthRoute());
                },
                child: Text(LocaleKeys.Next.tr()),
              ),
              const Spacer(),
              Text(
                LocaleKeys.You_can_change_language_anytime_in_the_settings.tr(),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
      ),
    );
  }
}
