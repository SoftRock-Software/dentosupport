part of 'phone_auth_bloc.dart';

enum PhoneAuthStatus {
  initial,
  otpSent,
  userNew,
  userOld;

  bool get isInitial => this == PhoneAuthStatus.initial;

  bool get isOtpSent => this == PhoneAuthStatus.otpSent;

  bool get isUserNew => this == PhoneAuthStatus.userNew;

  bool get isUserOld => this == PhoneAuthStatus.userOld;
}

class PhoneAuthState extends Equatable {
  const PhoneAuthState({
    this.status = PhoneAuthStatus.initial,
    this.loading = false,
    this.otpSent = false,
    this.error,
  });

  final PhoneAuthStatus status;
  final bool loading;
  final bool otpSent;
  final String? error;

  PhoneAuthState copyWith({
    PhoneAuthStatus? status,
    bool? loading,
    bool? otpSent,
    String? error,
  }) {
    return PhoneAuthState(
      status: status ?? this.status,
      loading: loading ?? this.loading,
      otpSent: otpSent ?? this.otpSent,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, loading, error, otpSent];
}
