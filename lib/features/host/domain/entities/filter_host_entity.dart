import 'package:equatable/equatable.dart';

class FilterHostEntity extends Equatable {
  String? province;
  int? minCapacity;
  int? maxCapacity;

  String? category;

  FilterHostEntity({
    this.province,
    this.minCapacity,
    this.maxCapacity,
    this.category,
  });

  @override
  List<Object?> get props => [province, minCapacity, maxCapacity, category];
}
