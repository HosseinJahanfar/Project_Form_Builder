import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../public_features/error/error_exception.dart';
import '../../services/report_form_repository.dart';

part 'report_form_event.dart';

part 'report_form_state.dart';

class ReportFormBloc extends Bloc<ReportFormEvent, ReportFormState> {
  final ReportFormRepository reportFormRepository;

  ReportFormBloc(this.reportFormRepository) : super(ReportFormInitial()) {
    on<CallReportFormEvent>(_callReportFormEvent);
  }

  FutureOr<void> _callReportFormEvent(
      CallReportFormEvent event, Emitter<ReportFormState> emit) async {
    emit(ReportFormLoadingState());

    try {
      List<dynamic> dataList =
          await reportFormRepository.callReportFormRepository(event.activeForm);
      emit(ReportFormCompletedState(
        listData: dataList,
        typeData: reportFormRepository.typeData,
      ));
    } on DioException catch (e) {
      emit(ReportFormErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }
}
