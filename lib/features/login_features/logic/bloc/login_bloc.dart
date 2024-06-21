import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../../model/login_model.dart';
import '../../model/otp_model.dart';
import '../../services/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<CallLoginEvent>(_onCallLoginEvent);
    on<CallOtpLoginEvent>(_onCallLoginOtpEvent);
    on<CallVerifyOtpLoginEvent>(_callVerifyOtpLoginEvent);
  }

  FutureOr<void> _onCallLoginEvent(
      CallLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final LoginModel loginModel =
          await _loginRepository.callLoginRepository(event.phone, event.pass);
      emit(LoginCompletedState(loginModel: loginModel));
    } on DioException catch (e) {
      emit(LoginErrorState(
        error: ErrorExceptions().fromError(e).toString(),
      ));
    }
  }

  FutureOr<void> _onCallLoginOtpEvent(
      CallOtpLoginEvent event, Emitter<LoginState> emit) async {
    try {
      await _loginRepository.callOtpLogin(event.phone);
      emit(LoginSendOtpCompletedState(
          successMsg: 'کد با موفقیت به شما ارسال شد.'));
    } on DioException catch (e) {
      emit(LoginErrorState(
        error: ErrorExceptions().fromError(e).toString(),
      ));
    }
  }

  FutureOr<void> _callVerifyOtpLoginEvent(
      CallVerifyOtpLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final OtpModel otpModel = await _loginRepository
          .callVerifyLoginRepository(event.phone, event.code);
      emit(LoginVerifyCompletedState(otpModel: otpModel));
    } on DioException catch (e) {
      emit(LoginErrorState(
        error: ErrorExceptions().fromError(e).toString(),
      ));
    }
  }
}
