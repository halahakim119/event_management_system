import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/user_profile_model.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  UserProfileModel? user;
  final userBox = Hive.box<UserProfileModel>('userBox');

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: userBox.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'you are not logged in',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Wrap(
                    textDirection: TextDirection.ltr,
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user!.name,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user!.phoneNumber,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.home_filled,
                              color: Theme.of(context).colorScheme.onPrimary),
                          Text(
                            user!.province,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
