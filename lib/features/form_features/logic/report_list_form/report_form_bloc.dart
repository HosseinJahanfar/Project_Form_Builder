import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../../model/form_list_model.dart';
import '../../services/form_repository.dart';

part 'report_form_event.dart';

part 'report_form_state.dart';

class ReportListFormBloc extends Bloc<ReportListFormEvent, ReportListFormState> {
  final FormRepository _formRepository;

  ReportListFormBloc(this._formRepository) : super(ReportFormInitial()) {
    on<CallReportFormEvent>((event, emit) async {
      emit(ReportFormLoadingState());
      try {
        List<FormListModel> formListModel =
            await _formRepository.callReportFormRepository();
        emit(ReportFormCompletedState(formListModel: formListModel));
      } on DioException catch (e) {
        emit(ReportFormErrorState(
            errorMsg: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}
