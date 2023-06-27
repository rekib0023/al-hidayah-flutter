import 'dart:async';

import 'package:al_hidayah/features/login/data_domain/auth_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../models/users.dart';
part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>(authInitial);
    on<AuthLoginButtonClickedEvent>(authLoginButtonClickedEvent);
    on<AuthLogoutButtonClickedEvent>(authLogoutButtonClickedEvent);
  }

  FutureOr<void> authInitial(AuthInitialEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> authLoginButtonClickedEvent(
      AuthLoginButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final User user =
          await _authRepository.loginUser(event.email, event.password);
      emit(AuthLoadedSucessState(user: user));
    } catch (err) {
      emit(AuthErrorState(message: "Invalid credentials"));
    }
  }

  FutureOr<void> authLogoutButtonClickedEvent(
      AuthLogoutButtonClickedEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingState());
    emit(AuthInitial());
  }
}
