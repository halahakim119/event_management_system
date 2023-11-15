import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/injection/injection_container.dart';
import '../../core/router/app_router.dart';
import '../draft/data/dtos/draft/draft_dto.dart';
import '../theme/presentation/theme_cubit.dart';
import '../user/data/models/user_model.dart';
import '../user/presentation/logic/bloc/user_bloc.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserBloc userBloc = sl<UserBloc>();
  void _onBoxChange() {
    if (mounted) {
      setState(() {
        getUserData();
      });
    }
  }

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    onTap: () {
                      context.router.push(const EditProfileRoute());
                    },
                    dense: true,
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit profile'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  const AboutListTile(
                    applicationName: 'event management system',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                        'Our Event Management System is a cutting-edge application designed to streamline and elevate event organization. With a user-friendly interface and powerful features, we empower event organizers to create, manage, and deliver exceptional experiences. From conferences and seminars to weddings and exhibitions, our platform offers seamless registration, attendee engagement tools, dynamic scheduling, and real-time analytics. Elevate your events with our innovative solution, making your vision a memorable reality.',
                    icon: Icon(Icons.tips_and_updates_outlined),
                    dense: true,
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  SwitchListTile(
                    value: themeMode == ThemeMode.dark,
                    dense: true,
                    title: const Text('Theme Mode'),
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        const Text('change language'),
                        Wrap(
                          children: [
                            TextButton(
                              onPressed: () async {
                                await context.setLocale(const Locale('ar'));
                              },
                              child: const Text('العربيه'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await context.setLocale(const Locale('en'));
                              },
                              child: const Text('English'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            userBox.isEmpty
                ? Container()
                : TextButton(
                    onPressed: () {
                      _logout();

                      Navigator.pop(context);
                    },
                    child: const Text("Log out"),
                  ),
            userBox.isEmpty
                ? Container()
                : TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => userBloc,
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserDeleted) {
                                  log('hi1');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      duration: const Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  _deleteAccount();
                                }
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this account forever?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                            DeleteUserEvent(
                                                user!.id!, user!.token!));
                                        if (state is UserDeleted) {
                                          log('hi2');
                                          // Show Snackbar for successful delete
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(state.message),
                                              duration:
                                                  const Duration(seconds: 3),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );

                                          // Delete the user from Hive
                                          _deleteAccount();
                                        }

                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Delete Account',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                  ),
          ]),
        );
      }),
    );
  }

  void _logout() async {
    final userBox = Hive.box<UserModel>('userBox');
    final draftBox = Hive.box<DraftDto>('draftBox');
    await userBox.clear();
    await draftBox.clear();
  }

  void _deleteAccount() async {
    if (!mounted) return;
    final userBox = Hive.box<UserModel>('userBox');
    await userBox.clear();
    if (!mounted) return;
  }
}
