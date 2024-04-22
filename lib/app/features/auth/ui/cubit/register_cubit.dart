import 'package:chatapp/app/features/auth/data/authentication_repository.dart';
import 'package:chatapp/core/di/di.dart';
import 'package:chatapp/core/utils/data_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    AuthenticationRepository? authenticationRepository,
  })  : _authenticationRepository =
            authenticationRepository ?? locator<AuthenticationRepository>(),
        super(const RegisterState.unknown());

  final AuthenticationRepository _authenticationRepository;

  Future<void> registerWithEmail(
    String email,
    String password,
  ) async {
    emit(const RegisterState.processing());

    final response =
        await _authenticationRepository.registerWithEmail(email, password);

    if (response.isFailure) {
      emit(RegisterState.failed(message: response.errorMessage));
    } else {
      emit(const RegisterState.done());
    }
  }
}
