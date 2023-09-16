import 'package:equatable/equatable.dart';
import 'package:event_management_system/features/invitaions/domain/entities/invite_entity.dart';

import '../../../event/domain/entities/event_entity.dart';

// Define the UserEntity class that extends Equatable.
// ignore: must_be_immutable
class UserEntity extends Equatable {
  // Unique identifier for the user.
  String? id;

  // Authentication token
  String? token;

  // User's name.
  String? name;

  // User's phone number.
  String? phoneNumber;

  // User's province.
  String? province;
  List<String>? FCMtokens;

  // List of maps representing the hosts that the current user is following.
  List<UserEntity>? following;

  // List of maps representing the events
  List<EventEntity>? events;

  List<InviteEntity>? invites;

  UserEntity(
      {this.id,
      this.token,
      this.name,
      this.phoneNumber,
      this.province,
      this.FCMtokens,
      this.following,
      this.events,
      this.invites});
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
        invites
      ];
}
