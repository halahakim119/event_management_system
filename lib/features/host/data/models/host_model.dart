import '../../../event/data/models/event_model.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/entities/host_entity.dart';

class HostModel extends HostEntity {
  HostModel({
    super.id,
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
  });

  factory HostModel.fromJson(Map<String, dynamic> json) {
    return HostModel(
      id: json['id'] ?? '',
      name: json['name'],
      province: json['province'],
      phoneNumber: json['phoneNumber'],
      photos: (json['photos'] as List<dynamic>?)
          ?.map((photo) => photo.toString())
          .toList(),
      category: json['category'],
      about: json['about'],
      services: (json['services'] as List<dynamic>?)
          ?.map((service) => service.toString())
          .toList(),
      serviceDescription: json['serviceDescription'],
      followers: (json['followers'] as List<dynamic>?)
          ?.map((follower) => UserModel.fromJson(follower).toEntity())
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((event) => EventModel.fromJson(event).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
    };
  }

  factory HostModel.fromEntity(HostEntity? entity) {
    return HostModel(
      id: entity!.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      province: entity.province,
      photos: entity.photos,
      category: entity.category,
      about: entity.about,
      services: entity.services,
      serviceDescription: entity.serviceDescription,
      followers: entity.followers,
      events: entity.events,
    );
  }

  HostEntity toEntity() {
    return HostEntity(
      id: id,
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
    );
  }
}
