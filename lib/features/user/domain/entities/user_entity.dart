import 'package:equatable/equatable.dart';

import '../../../event/domain/entities/event_entity.dart';

// Define the UserEntity class that extends Equatable.
// ignore: must_be_immutable
class UserEntity extends Equatable {
  // Unique identifier for the user.
  final String id;

  // Authentication token
  final String token;

  // User's name.
  String name;

  // User's phone number.
  String phoneNumber;

  // User's province.
  String province;
  List<String> FCMtokens;

  // List of maps representing the hosts that the current user is following.
  List<UserEntity>? following;

  // List of maps representing the events
  List<EventEntity>? events;

  List<EventEntity>? attendance;

  UserEntity(
      {required this.id,
      required this.token,
      required this.name,
      required this.phoneNumber,
      required this.province,
      required this.FCMtokens,
      this.following,
      this.events,
      this.attendance});
  // Equatable requires overriding the 'props' getter to compare instances for equality.
  @override
  List<Object?> get props => [
        id,
        name,
        FCMtokens,
        phoneNumber,
        token,
        province,
        following,
        events,
        attendance
      ];
}
