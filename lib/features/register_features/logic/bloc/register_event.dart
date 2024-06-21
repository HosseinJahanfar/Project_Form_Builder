part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class CallRegisterEvent extends RegisterEvent {
  final String phone;
  final String password;
  final String fullName;
  final String email;

  CallRegisterEvent(
      {required this.phone,
      required this.password,
      required this.fullName,
      required this.email});
}
