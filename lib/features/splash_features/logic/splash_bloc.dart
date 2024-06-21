import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../model/apps_model.dart';
import '../services/splash_repository.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository _splashRepository;

  SplashBloc(this._splashRepository) : super(SplashInitial()) {
    on<CallSplashEvent>(_callSplashEvent);
  }

  FutureOr<void> _callSplashEvent(
      CallSplashEvent event, Emitter<SplashState> emit) async {
    try {
      AppsModel appsModel = await _splashRepository.callSplashApiRepository();
      emit(SplashCompletedState(appsModel: appsModel));
    } on DioException catch (e) {
      emit(SplashErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }
}
