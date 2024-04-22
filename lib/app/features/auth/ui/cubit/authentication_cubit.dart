import 'dart:async';
import 'package:chatapp/app/features/auth/data/authentication_repository.dart';
import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/core/di/di.dart';
import 'package:chatapp/core/navigation/app_routers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'authentication_state.dart';

enum AuthenticationStatus {
  loading,
  authenticated,
  unauthenticated;
}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    AuthenticationRepository? authenticationRepository,
    GoRouter? routers
  })  : _authenticationRepository =
            authenticationRepository ?? locator<AuthenticationRepository>(),
            _routers = routers ?? AppRoutes.getRouters(0),
        super(AuthenticationState.initial(authenticationRepository!.user)) {
    _initUserSubscription();
  }
  
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserModel?> _userSubscription;
  final GoRouter _routers;

  void _initUserSubscription() {
    _userSubscription =
        _authenticationRepository.userSubscription.listen(_onUserChanged);
  }

  void _onUserChanged(UserModel? user) {
    if (user == null || user.isEmpty) {
      emit(const AuthenticationState.unauthenticated());
      _routers.refresh();
    } else {
      emit(AuthenticationState.authenticated(user));
    }
  }

  void signOut() => unawaited(_authenticationRepository.signOut());

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
