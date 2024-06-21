import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../../model/form_list_model.dart';
import '../../services/form_repository.dart';

part 'list_form_event.dart';

part 'list_form_state.dart';

class ListFormBloc extends Bloc<ListFormEvent, ListFormState> {
  final FormRepository _formRepository;

  ListFormBloc(this._formRepository) : super(ListFormInitial()) {
    on<CallListFormEvent>(_callFormListEvent);
  }


  FutureOr<void> _callFormListEvent(CallListFormEvent event, Emitter<ListFormState> emit) async{
    emit(ListFormLoadingState());
    try {
      List<FormListModel> formListModel =
      await _formRepository.callFormListRepository();
      emit(ListFormCompletedState(formListModel: formListModel));
    } on DioException catch (e) {
      emit(ListFormErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }
}
