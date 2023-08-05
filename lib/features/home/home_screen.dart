import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../theme/presentation/theme_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
          BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
        return Column(
          children: [
            Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                // Toggle the theme mode when the switch is toggled
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(Locale('ar'));
              },
              child: Text('العربيه'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(Locale('en'));
              },
              child: Text('English'),
            ),
          ],
        );
      })),
    );
  }
}
