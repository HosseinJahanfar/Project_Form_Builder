part of 'form_builder_bloc.dart';

@immutable
sealed class FormBuilderEvent {}

final class CallFormBuilderEvent extends FormBuilderEvent {
  final String activeForm;

  CallFormBuilderEvent({required this.activeForm});
}
