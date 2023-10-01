import '../../domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    super.id,
    super.price,
    super.title,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      price: json['price'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'title': title,
    };
  }

  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      price: price,
      title: title,
    );
  }
}
