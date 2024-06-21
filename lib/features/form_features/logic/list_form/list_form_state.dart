part of 'list_form_bloc.dart';

@immutable
sealed class ListFormState {}

final class ListFormInitial extends ListFormState {}

final class ListFormLoadingState extends ListFormState {}

final class ListFormCompletedState extends ListFormState {
  final List<FormListModel> formListModel;

  ListFormCompletedState({required this.formListModel});
}

final class ListFormErrorState extends ListFormState {
  final String errorMsg;

  ListFormErrorState({required this.errorMsg});
}
