class User {
  final String id;
  final String email;
  final String fullName;
  final bool isActive;
  final List<String> roles;
  final bool deleted;
  final DateTime? deletedAt;

  User({
    required this.isActive,
    required this.roles,
    required this.deleted,
    required this.id,
    required this.email,
    required this.fullName,
    this.deletedAt,
  });
}
