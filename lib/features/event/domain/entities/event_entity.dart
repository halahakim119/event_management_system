import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../profile/domain/entities/user_entity.dart';

class EventEntity extends Equatable {
  final String id;
  final HostEntity host;
  final String hostId;
  final UserEntity planner;
  final String plannerId;
  final int guestsNumber;
  final TimeOfDay startsAt;
  final TimeOfDay endsAt;
  final String description;
  final String type;
  final String title;
  final DateTime startingDate;
  final DateTime endingDate;
  final String dressCode;
  final bool? adultsOnly;
  final bool? food;
  final bool? alcohol;
  final List<UserEntity>? guests;
  final List<UserEntity>? confirmedGuests;
  final String postType;

  const EventEntity({
    required this.id,
    required this.host,
    required this.hostId,
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
    required this.dressCode,
    this.adultsOnly,
    this.food,
    this.alcohol,
    this.guests,
    this.confirmedGuests,
    required this.postType,
  });

  @override
  List<Object?> get props => [
        id,
        host,
        planner,
        hostId,
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
        confirmedGuests,
        postType,
      ];
}

class HostEntity {}
