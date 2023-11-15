import 'package:equatable/equatable.dart';

class FilterHostEntity extends Equatable {
  String? province;
  int? minCapacity;
  int? maxCapacity;
  int? count;
  String? category;

  FilterHostEntity(
      {this.province,
      this.minCapacity,
      this.maxCapacity,
      this.category,
      this.count});

  @override
  List<Object?> get props =>
      [province, minCapacity, maxCapacity, category, count];
}
