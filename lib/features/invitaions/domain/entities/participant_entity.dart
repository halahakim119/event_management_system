import 'package:equatable/equatable.dart';

class ParticipantEntity extends Equatable {
  final String? id;
  final String? name;
  final String? phoneNumber;

  ParticipantEntity({
     this.id,
     this.name,
     this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber];
}
