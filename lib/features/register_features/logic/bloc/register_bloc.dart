import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../public_features/error/error_exception.dart';
import '../../model/register_model.dart';
import '../../services/register_repositroy.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterBloc(this._registerRepository) : super(RegisterInitial()) {
    on<CallRegisterEvent>(_callRegisterEvent);
  }

  FutureOr<void> _callRegisterEvent(
      CallRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());

    try {
      RegisterModel registerModel =
          await _registerRepository.callRegisterRepository(
              event.email, event.phone, event.password, event.fullName);
      emit(RegisterCompletedState(registerModel: registerModel));
    } on DioException catch (e) {
      emit(
          RegisterErrorState(erorr: ErrorExceptions().fromError(e).toString()));
    }
  }
}
