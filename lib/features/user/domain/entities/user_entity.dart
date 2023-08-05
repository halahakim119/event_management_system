import 'package:equatable/equatable.dart';

// Define the UserEntity class that extends Equatable.
class UserEntity extends Equatable {
  // Unique identifier for the user.
  final String id;

  // User's name.
  String name;

  // User's phone number.
  String phoneNumber;

  // Authentication token (optional).
  final String token;

  // User's province.
  String province;

  // User's password.
  String? password;

  // List of maps representing the users that the current user is following.
  List<Map<String, dynamic>>? following;

  // List of maps representing the events associated with the user (optional).
  List<Map<String, dynamic>>? events;

  // Constructor for the UserEntity class.
  UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.token,
    required this.province,
    this.password,
    this.following,
    this.events,
  });

  // Equatable requires overriding the 'props' getter to compare instances for equality.
  @override
  List<Object?> get props =>
      [id, name, phoneNumber, token, province, following, events, password];
}
