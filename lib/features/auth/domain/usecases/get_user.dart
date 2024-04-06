import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:dento_support/features/auth/domain/domain.dart';

class GetUser {
  const GetUser(this.repository);

  final AuthRepository repository;

  Future<User> call() => repository.getMe();
}
