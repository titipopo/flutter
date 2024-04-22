import 'package:chatapp/app/features/auth/data/authentication_repository.dart';
import 'package:chatapp/core/di/di.dart';
import 'package:chatapp/core/utils/data_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    AuthenticationRepository? authenticationRepository,
  })  : _authenticationRepository =
            authenticationRepository ?? locator<AuthenticationRepository>(),
        super(const SignInState.unknown());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signInWithEmail(
    String email,
    String password,
  ) async {
    emit(const SignInState.processing());

    final response =
        await _authenticationRepository.signInWithEmail(email, password);

    if (response.isFailure) {
      emit(SignInState.failed(message: response.errorMessage));
    } else {
      emit(const SignInState.done());
    }
  }

  Future<void> signInWithGithub() async {
    emit(const SignInState.processing());

    final response = await _authenticationRepository.signInWithGithub();

    if (response.isFailure) {
      emit(SignInState.failed(message: response.errorMessage));
    } else {
      emit(const SignInState.done());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(const SignInState.processing());

    final response = await _authenticationRepository.signInWithGoogle();

    if (response.isFailure) {
      emit(SignInState.failed(message: response.errorMessage));
    } else {
      emit(const SignInState.done());
    }
  }
}
