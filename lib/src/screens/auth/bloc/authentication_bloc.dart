import 'package:chatapp/src/models/user.dart';
import 'package:chatapp/src/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();

  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUp>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user =
            await authService.signUp(event.email, event.password);
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('create user failed'));
        }
      } catch (e) {
        print(e.toString());
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

    on<SignIn>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        final UserModel? user =
            await authService.signIn(event.email, event.password);
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('login failed'));
        }
      } catch (e) {
        print(e.toString());
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOut();
      } catch (e) {
        print('error');
        print(e.toString());
      }
      emit(const AuthenticationLoadingState(isLoading: false));
    });
  }
}
