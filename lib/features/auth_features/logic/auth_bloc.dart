import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../services/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CallAuthEvent>(_callAuth);
  }

  FutureOr<void> _callAuth(CallAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final bool userStatus =
          await authRepository.callAuthApiRepository(event.phoneNumber);

      emit(AuthCompletedState(userStatus: userStatus));
    } on DioException catch (e) {
      emit(AuthErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}
