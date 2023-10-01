import '../../domain/entities/filter_host_entity.dart';

class FilterHostModel extends FilterHostEntity {
  FilterHostModel({
    super.province,
    super.minCapacity,
    super.maxCapacity,
    super.category,
  });

  factory FilterHostModel.fromJson(Map<String, dynamic> json) {
    return FilterHostModel(
      province: json['province'],
      minCapacity: json['minCapacity'],
      maxCapacity: json['maxCapacity'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province': province,
      'minCapacity': minCapacity,
      'maxCapacity': maxCapacity,
      'category': category,
    };
  }

  FilterHostEntity toEntity() {
    return FilterHostEntity(
      province: province,
      minCapacity: minCapacity,
      maxCapacity: maxCapacity,
      category: category,
    );
  }
}
