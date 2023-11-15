import '../../../event/data/models/event_model.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/entities/host_entity.dart';
import 'service_model.dart';

class HostModel extends HostEntity {
  HostModel(
      {super.id,
      super.name,
      super.phoneNumber,
      super.province,
      super.photos,
      super.category,
      super.about,
      super.services,
      super.serviceDescription,
      super.followers,
      super.events,
      super.locationDescription,
      super.locationLink,
      super.basePrice});

  factory HostModel.fromJson(Map<String, dynamic> json) {
    return HostModel(
      id: json['id'],
      basePrice: json['basePrice'],
      name: json['name'],
      province: json['province'],
      phoneNumber: json['phoneNumber'],
      photos: (json['photos'] as List<dynamic>?)
          ?.map((photo) => photo.toString())
          .toList(),
      category: json['category'],
      about: json['about'],
      services: (json['services'] as List<dynamic>?)
          ?.map((services) => ServiceModel.fromJson(services).toEntity())
          .toList(),
      serviceDescription: json['serviceDescription'],
      followers: (json['followers'] as List<dynamic>?)
          ?.map((follower) => UserModel.fromJson(follower).toEntity())
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((event) => EventModel.fromJson(event).toEntity())
          .toList(),
      locationDescription: json['locationDescription'],
      locationLink: json['locationLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'basePrice': basePrice,
      'name': name,
      'phoneNumber': phoneNumber,
      'province': province,
      'photos': photos,
      'category': category,
      'about': about,
      'services': services,
      'serviceDescription': serviceDescription,
      'followers': followers
          ?.map((follower) => UserModel.fromEntity(follower).toJson())
          .toList(),
      'events': events
          ?.map((event) => EventModel.fromEntity(event).toJson())
          .toList(),
      'locationDescription': locationDescription,
      'locationLink': locationLink
    };
  }

  factory HostModel.fromEntity(HostEntity? entity) {
    return HostModel(
        id: entity?.id,
        basePrice: entity?.basePrice,
        name: entity?.name,
        phoneNumber: entity?.phoneNumber,
        province: entity?.province,
        photos: entity?.photos,
        category: entity?.category,
        about: entity?.about,
        services: entity?.services,
        serviceDescription: entity?.serviceDescription,
        followers: entity?.followers,
        events: entity?.events,
        locationDescription: entity?.locationDescription,
        locationLink: entity?.locationLink);
  }

  HostEntity toEntity() {
    return HostEntity(
        id: id,
        basePrice: basePrice,
        phoneNumber: phoneNumber,
        name: name,
        province: province,
        photos: photos,
        category: category,
        about: about,
        services: services,
        serviceDescription: serviceDescription,
        followers: followers,
        events: events,
        locationDescription: locationDescription,
        locationLink: locationLink);
  }
}
