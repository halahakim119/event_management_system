import 'package:equatable/equatable.dart';

class InitEntity extends Equatable {
  final String? id;
  final String plannerId;
  final String title;
  final String description;
  final int guestsNumber;
  final String type;
  final String postType;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime startingDate;
  final DateTime endingDate;
  final bool adultsOnly;
  final bool food;
  final bool alcohol;
  final String? dressCode;
  final List<String>? guests;

  const InitEntity({
     this.id,
    required this.plannerId,
    required this.guestsNumber,
    required this.startsAt,
    required this.endsAt,
    required this.description,
    required this.type,
    required this.title,
    required this.startingDate,
    required this.endingDate,
    required this.dressCode,
    required this.adultsOnly,
    required this.food,
    required this.alcohol,
    this.guests,
    required this.postType,
  });

  @override
  List<Object?> get props => [
        id,
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
