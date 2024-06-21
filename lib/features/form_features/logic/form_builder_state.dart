part of 'form_builder_bloc.dart';

@immutable
sealed class FormBuilderState {}

final class FormBuilderInitial extends FormBuilderState {}

final class FormBuilderLoadingState extends FormBuilderState {}

final class FormBuilderCompletedState extends FormBuilderState {
  final List<dynamic>? listData;
  final List<dynamic>? typeData;
  final FormModel formModel;
  FormBuilderCompletedState( {required this.listData, required this.typeData ,required this.formModel});
}

final class FormBuilderErrorState extends FormBuilderState {
  final String errorMsg;

  FormBuilderErrorState({required this.errorMsg});
}

