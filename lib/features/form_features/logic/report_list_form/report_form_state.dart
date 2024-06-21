part of 'report_form_bloc.dart';

@immutable
sealed class ReportListFormState {}

final class ReportFormInitial extends ReportListFormState {}

final class ReportFormLoadingState extends ReportListFormState {}

final class ReportFormCompletedState extends ReportListFormState {
  final List<FormListModel> formListModel;

  ReportFormCompletedState({required this.formListModel});
}

final class ReportFormErrorState extends ReportListFormState {
  final String errorMsg;

  ReportFormErrorState({required this.errorMsg});
}
