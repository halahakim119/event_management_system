// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:event_management_system/features/event/domain/entities/init_entity.dart';
import 'package:event_management_system/features/event/domain/entities/request_entity.dart';

import '../../../event/domain/entities/event_entity.dart';

// Define the UserEntity class that extends Equatable.
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

  // List of maps representing the hosts that the current user is following.
  List<UserEntity>? following;

  // List of maps representing the events
  List<EventEntity>? events;
  List<RequestEntity>? requests;
  List<InitEntity>? inits;
  List<EventEntity>? attendance;

   UserEntity({
    required this.id,
    required this.token,
    required this.name,
    required this.phoneNumber,
    required this.province,
    this.following,
    this.events,
    this.requests,
    this.inits,
    this.attendance
  });
  // Equatable requires overriding the 'props' getter to compare instances for equality.
  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        token,
        province,
        following,
        events,
        requests,
        inits,
        attendance
      ];
}
