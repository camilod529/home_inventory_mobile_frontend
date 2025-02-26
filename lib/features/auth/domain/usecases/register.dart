import 'package:home_inventory_app/features/auth/domain/entities/user.dart';
import 'package:home_inventory_app/features/auth/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<User> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
