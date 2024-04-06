part of 'user_cubit.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.errorMessage = '',
  });

  final UserStatus status;
  final String errorMessage;

  UserState copyWith({
    UserStatus? status,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
