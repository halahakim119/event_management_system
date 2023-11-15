import 'package:equatable/equatable.dart';

import '../../../event/domain/entities/event_entity.dart';
import '../../../user/domain/entities/user_entity.dart';
import 'service_entity.dart';

class HostEntity extends Equatable {
  String? id;
  String? name;
  String? phoneNumber;
  String? province;
  List<String>? photos;
  String? category;
  String? about;
  List<ServiceEntity>? services;
  int? basePrice;
  String? serviceDescription;
  List<UserEntity>? followers;
  List<EventEntity>? events;
  String? locationLink;
  String? locationDescription;

  HostEntity(
      {this.id,
      this.name,
      this.province,
      this.phoneNumber,
      this.photos,
      this.category,
      this.about,
      this.services,
      this.serviceDescription,
      this.followers,
      this.events,
      this.locationDescription,
      this.locationLink,
      this.basePrice});
  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        province,
        photos,
        category,
        about,
        services,
        serviceDescription,
        followers,
        events,
        locationDescription,
        locationLink,
        basePrice
      ];
}
