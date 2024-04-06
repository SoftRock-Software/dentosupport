part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == SignupStatus.initial;
  bool get isLoading => this == SignupStatus.loading;
  bool get isSuccess => this == SignupStatus.success;
  bool get hasError => this == SignupStatus.error;
}

class SignupState extends Equatable {
  const SignupState({
    this.status = SignupStatus.initial,
    this.errorMessage = '',
  });

  final SignupStatus status;
  final String errorMessage;

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
