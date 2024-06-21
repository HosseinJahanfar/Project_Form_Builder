part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

/// call Password Login
final class LoginLoadingState extends LoginState {}

final class LoginCompletedState extends LoginState {
  final LoginModel loginModel;

  LoginCompletedState({required this.loginModel});
}

final class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

/// call send-otp login
final class LoginSendOtpCompletedState extends LoginState {
  final String successMsg;

  LoginSendOtpCompletedState({required this.successMsg});
}

//call verify-otp login
final class LoginVerifyCompletedState extends LoginState {
  final OtpModel otpModel;

  LoginVerifyCompletedState({required this.otpModel});
}
