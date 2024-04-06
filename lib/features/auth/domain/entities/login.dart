import 'package:equatable/equatable.dart';

class Login extends Equatable {
  const Login({
    required this.token,
    required this.user,
  });

  final String token;
  final String? user;

  @override
  List<Object?> get props => [token, user];
}
