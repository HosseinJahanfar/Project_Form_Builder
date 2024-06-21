part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterCompletedState extends RegisterState {
  final RegisterModel registerModel;

  RegisterCompletedState({required this.registerModel});
}

final class RegisterErrorState extends RegisterState {
  final String erorr;

  RegisterErrorState({required this.erorr});
}
