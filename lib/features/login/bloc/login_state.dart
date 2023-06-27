part of "login_bloc.dart";

@immutable
abstract class AuthState {}

abstract class AuthActionState extends AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedSucessState extends AuthState {
  final User user;
  AuthLoadedSucessState({required this.user});
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

class AuthLoginButtonClickedState extends AuthActionState {}

class AuthLogoutButtonClickedState extends AuthActionState {}
