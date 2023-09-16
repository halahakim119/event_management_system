import 'package:equatable/equatable.dart';

class InviteEntity extends Equatable {
  final String id;
  final String title;
  final String type;

  InviteEntity({
    required this.id,
    required this.title,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, type];
}
