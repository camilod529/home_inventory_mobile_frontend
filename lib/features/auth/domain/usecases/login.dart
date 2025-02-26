import 'package:home_inventory_app/features/auth/domain/entities/user.dart';
import 'package:home_inventory_app/features/auth/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
