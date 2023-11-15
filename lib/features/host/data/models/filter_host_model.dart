import '../../domain/entities/filter_host_entity.dart';

class FilterHostModel extends FilterHostEntity {
  FilterHostModel(
      {super.province,
      super.minCapacity,
      super.maxCapacity,
      super.category,
      super.count});

  factory FilterHostModel.fromJson(Map<String, dynamic> json) {
    return FilterHostModel(
        province: json['province'],
        minCapacity: json['minCapacity'],
        maxCapacity: json['maxCapacity'],
        category: json['category'],
        count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'province': province,
      'minCapacity': minCapacity,
      'maxCapacity': maxCapacity,
      'category': category,
      'count': count
    };
  }

  FilterHostEntity toEntity() {
    return FilterHostEntity(
        province: province,
        minCapacity: minCapacity,
        maxCapacity: maxCapacity,
        category: category,
        count: count);
  }
}
