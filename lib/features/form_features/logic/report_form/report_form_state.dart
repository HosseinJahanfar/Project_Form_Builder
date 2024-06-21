part of 'report_form_bloc.dart';

@immutable
sealed class ReportFormState {}

final class ReportFormInitial extends ReportFormState {}

final class ReportFormLoadingState extends ReportFormState {}

final class ReportFormCompletedState extends ReportFormState {
  final List<dynamic>? listData;
  final List<dynamic>? typeData;

  ReportFormCompletedState({required this.listData, required this.typeData});
}

final class ReportFormErrorState extends ReportFormState {
  final String errorMsg;

  ReportFormErrorState({required this.errorMsg});
}
