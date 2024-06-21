part of 'report_form_bloc.dart';

@immutable
sealed class ReportFormEvent {}

final class CallReportFormEvent extends ReportFormEvent{
  final String activeForm;

  CallReportFormEvent({required this.activeForm});
}
