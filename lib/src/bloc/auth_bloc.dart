import 'dart:developer';

import 'package:chatapp/src/models/user.dart';
import 'package:chatapp/src/services/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthState.initial()) {
    on<SignUp>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        final UserModel? user =
            await authService.signUp(event.email, event.password);
        if (user != null) {
          emit(state.copyWith(status: AuthStatus.signup));
        } else {
          emit(state.copyWith(
              status: AuthStatus.error, errorMessage: 'create user failed'));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignIn>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        final UserModel? user =
            await authService.signIn(event.email, event.password);
        if (user != null) {
          emit(state.copyWith(status: AuthStatus.login, user: user));
        } else {
          emit(state.copyWith(
              status: AuthStatus.error, errorMessage: 'login failed'));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignOut>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        authService.signOut();
        emit(state.copyWith(status: AuthStatus.signout));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
            status: AuthStatus.error, errorMessage: 'logout failed'));
      }
    });
  }
}
