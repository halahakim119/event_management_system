import 'package:equatable/equatable.dart';

class FilterHostEntity extends Equatable {
  String? province;
  int? minCapacity;
  int? maxCapacity;
  List<String>? services;
  String? category;

  FilterHostEntity({
    this.province,
    this.minCapacity,
    this.maxCapacity,
    this.services,
    this.category,
  });

  @override
  List<Object?> get props => [province, minCapacity, maxCapacity, services, category];
}
