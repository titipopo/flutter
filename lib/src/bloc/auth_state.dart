part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  error,
  login,
  signup,
  signout,
}

class AuthState extends Equatable {
  const AuthState({required this.status, this.errorMessage, this.user});
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  static AuthState initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith(
          {AuthStatus? status, UserModel? user, String? errorMessage}) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [status.name];
}
