part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class SignUp extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUp(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignIn extends AuthenticationEvent {
  final String email;
  final String password;

  const SignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {}
