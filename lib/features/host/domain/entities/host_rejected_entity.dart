import 'package:equatable/equatable.dart';

import '../../../host/domain/entities/host_entity.dart';

class HostRejectedEntity extends Equatable {
  String? id;
  String? message;
  HostEntity? host;

  HostRejectedEntity({
    String? id,
    this.message,
    this.host,
  });

  @override
  List<Object?> get props => [
        id,
        message,
        host,
      ];
}
