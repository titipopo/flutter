part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  error,
  authenticated,
  login,
  signup,
  signout,
}

class AuthState extends Equatable {
  const AuthState({required this.status, this.errorMessage, this.user});
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  static AuthState initial() {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;

    if (loggedIn) {
      final UserModel user = UserModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser?.email ?? '',
        displayName: FirebaseAuth.instance.currentUser?.displayName ?? '',
        photoURL: FirebaseAuth.instance.currentUser?.photoURL ?? '',
        metadata: FirebaseAuth.instance.currentUser!.metadata,
      );
      return AuthState(status: AuthStatus.authenticated, user: user);
    }
    return const AuthState(status: AuthStatus.initial);
  }

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
