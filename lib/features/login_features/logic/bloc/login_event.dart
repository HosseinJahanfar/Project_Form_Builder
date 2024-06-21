part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class CallLoginEvent extends LoginEvent {
  final String phone;
  final String pass;

  CallLoginEvent({required this.phone, required this.pass});
}

final class CallOtpLoginEvent extends LoginEvent {
  final String phone;

  CallOtpLoginEvent({required this.phone});
}

final class CallVerifyOtpLoginEvent extends LoginEvent {
  final String phone;
  final String code;

  CallVerifyOtpLoginEvent({required this.phone, required this.code});
}
