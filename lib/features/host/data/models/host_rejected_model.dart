import '../../domain/entities/host_rejected_entity.dart';
import 'host_model.dart';

class HostRejectedModel extends HostRejectedEntity {
  HostRejectedModel({
    super.id,
    super.message,
    super.host,
  });

  factory HostRejectedModel.fromJson(Map<String, dynamic> json) {
    return HostRejectedModel(
      id: json['id'],
      message: json['message'],
      host: HostModel.fromJson(json['host']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? hostData;
    // Case 4: To JSON
    if (host != null) {
      hostData = HostModel.fromEntity(host).toJson();
    }

    return {
      'id': id,
      'message': message,
      'host': hostData,
    };
  }

  factory HostRejectedModel.fromEntity(HostRejectedEntity? entity) {
    return HostRejectedModel(
      id: entity?.id,
      message: entity?.message,
      host: entity?.host,
    );
  }

  HostRejectedEntity toEntity() {
    return HostRejectedEntity(
      id: id,
      message: message,
      host: host,
    );
  }
}
