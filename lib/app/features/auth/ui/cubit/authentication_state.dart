part of 'authentication_cubit.dart';

final class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState._({
    required this.status,
    this.user = UserModel.empty,
  });
  

  factory AuthenticationState.initial(UserModel user) {
    final bool loggedIn = user.isNotEmpty;

    if (loggedIn) {
      return AuthenticationState._(
          user: user, status: AuthenticationStatus.unauthenticated);
    }
    return const AuthenticationState._(
        status: AuthenticationStatus.unauthenticated);
  }

  const AuthenticationState.authenticated(UserModel user)
      : this._(
          user: user,
          status: AuthenticationStatus.authenticated,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
