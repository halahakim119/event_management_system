import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../data/models/user_profile_service.dart';
import '../widgets/not_logged_in.dart';
import '../widgets/profile_buttons.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userProfileService = sl<UserProfileService>();
  @override
  Widget build(BuildContext context) {
    final user = userProfileService.user;
    final userBox = userProfileService.userBox;

    return Scaffold(
      appBar: userBox.isEmpty
          ? null
          : AppBar(
              actions: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  alignment: WrapAlignment.end,
                  direction: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        Text(
                          user!.province,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Text(
                      user.phoneNumber,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
              leading: IconButton(
                onPressed: () {
                  // Handle notifications action
                },
                icon: const Icon(Icons.notifications_none_rounded),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: userBox.isEmpty ? const NotLoggedIn() : ProfileBody(),
    );
  }
}
