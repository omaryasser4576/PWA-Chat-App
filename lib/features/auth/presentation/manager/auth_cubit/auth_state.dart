part of 'auth_cubit.dart';

sealed class AuthStates {}

final class AuthInitial extends AuthStates {}

// login
final class AuthLoginLoading extends AuthStates {}

final class AuthLoginSuccess extends AuthStates {
  final UserModel user;

  AuthLoginSuccess(this.user);
}

// sign in
final class AuthSignInLoading extends AuthStates {}

final class AuthSignInSuccess extends AuthStates {}

// sign in compelete profile
final class AuthCompleteProfileLoading extends AuthStates {}

final class AuthCompleteProfileSuccess extends AuthStates {
  final UserModel user;

  AuthCompleteProfileSuccess(this.user);
}

// failure
final class AuthFailure extends AuthStates {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}

final class AuthLoggedOut extends AuthStates {}

final class AuthAlreadyLoggedIn extends AuthStates {}
