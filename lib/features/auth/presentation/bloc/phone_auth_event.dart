part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}

class ResetEvent extends PhoneAuthEvent {
  const ResetEvent();
}

class SendOtpEvent extends PhoneAuthEvent {
  const SendOtpEvent({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends PhoneAuthEvent {
  const VerifyOtpEvent({required this.smsCode});

  final String smsCode;

  @override
  List<Object> get props => [smsCode];
}
