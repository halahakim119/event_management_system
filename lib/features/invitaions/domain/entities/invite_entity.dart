import 'package:equatable/equatable.dart';

class InviteEntity extends Equatable {
  final String? id;
  final String? title;
  final String? type;

  InviteEntity({
     this.id,
     this.title,
     this.type,
  });

  @override
  List<Object?> get props => [id, title, type];
}
