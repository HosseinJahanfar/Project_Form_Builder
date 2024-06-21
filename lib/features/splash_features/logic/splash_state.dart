part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoadingState extends SplashState {}

final class SplashCompletedState extends SplashState {
  final AppsModel appsModel;

  SplashCompletedState({required this.appsModel});
}

final class SplashErrorState extends SplashState {
  final String errorMsg;

  SplashErrorState({required this.errorMsg});
}
