part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CallAuthEvent extends AuthEvent {
  final String phoneNumber;

  CallAuthEvent({required this.phoneNumber});
}
