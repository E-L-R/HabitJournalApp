part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

final class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

final class LoginNavigateToForgotPassword extends LoginState {
  LoginNavigateToForgotPassword();
}