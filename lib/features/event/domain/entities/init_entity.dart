import 'package:equatable/equatable.dart';
import 'package:event_management_system/features/profile/domain/entities/user_entity.dart';

class InitEntity extends Equatable {
  final String id;
  final UserEntity planner;
  final String plannerId;
  final int guestsNumber;
  final DateTime startsAt;
  final DateTime endsAt;
  final String description;
  final String type;
  final String title;
  final DateTime startingDate;
  final DateTime endingDate;
  final String? dressCode;
  final bool? adultsOnly;
  final bool? food;
  final bool? alcohol;
  final List<String>? guests;
  final String postType;

  const InitEntity({
    required this.id,
    required this.planner,
    required this.plannerId,
    required this.guestsNumber,
    required this.startsAt,
    required this.endsAt,
    required this.description,
    required this.type,
    required this.title,
    required this.startingDate,
    required this.endingDate,
    this.dressCode,
    this.adultsOnly,
    this.food,
    this.alcohol,
    this.guests,
    required this.postType,
  });

  @override
  List<Object?> get props => [
        id,
        planner,
        plannerId,
        guestsNumber,
        startsAt,
        endsAt,
        description,
        type,
        title,
        startingDate,
        endingDate,
        dressCode,
        adultsOnly,
        food,
        alcohol,
        guests,
        postType,
      ];
}
