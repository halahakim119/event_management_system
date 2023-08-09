import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/user_profile_model.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
      appBar: AppBar(),
      body: 
      userBox.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'you are not logged in',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ))
          : 
          SingleChildScrollView(
              child: Column(children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(user!.name),
                         const  SizedBox(height: 10),
                          // Text(user!.province),
                        ],
                      ),
                      trailing: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ])),
    );
  }
}
