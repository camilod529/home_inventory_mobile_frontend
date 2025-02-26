import 'package:home_inventory_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.isActive,
    required super.roles,
    required super.deleted,
    super.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      isActive: json['isActive'],
      roles: List<String>.from(json['roles']), // Convertir lista correctamente
      deleted: json['deleted'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'isActive': isActive,
      'roles': roles,
      'deleted': deleted,
      'deletedAt': deletedAt,
    };
  }
}
