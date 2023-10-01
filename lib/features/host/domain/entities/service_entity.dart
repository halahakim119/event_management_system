import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  String? id;
  String? title;
  String? price;

  ServiceEntity({
    this.id,
    this.title,
    this.price,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        price,
      ];
}
