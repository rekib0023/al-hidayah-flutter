part of 'login_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthLoginButtonClickedEvent extends AuthEvent {
  final String email, password;
  AuthLoginButtonClickedEvent({
    required this.email,
    required this.password,
  });
}

class AuthLogoutButtonClickedEvent extends AuthEvent {}
