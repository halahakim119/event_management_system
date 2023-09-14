import 'package:hive_flutter/hive_flutter.dart';

import 'user_profile_model.dart';

class UserProfileService {
  UserProfileModel? user;
  final Box<UserProfileModel> userBox;

  UserProfileService({required this.userBox});

  void init() {
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void _onBoxChange() {
    getUserData();
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }
}
