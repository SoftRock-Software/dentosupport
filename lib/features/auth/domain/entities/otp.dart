import 'package:equatable/equatable.dart';

class Otp extends Equatable {
  const Otp({
    required this.verifyId,
    required this.token,
    this.status = '',
    this.message = '',
  });

  final String status;
  final String message;
  final String verifyId;
  final String token;

  @override
  List<Object?> get props => [verifyId, token, status, message];
}
