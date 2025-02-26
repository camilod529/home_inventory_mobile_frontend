import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
  final String id;
  final String name;
  final String ownerId;
  final List<String> members;

  const Inventory({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.members,
  });

  @override
  List<Object?> get props => [id, name, ownerId, members];
}
