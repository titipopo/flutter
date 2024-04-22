import 'dart:async';

import 'package:chatapp/app/features/auth/data/authentication_interface.dart';
import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/app/features/auth/data/user_dao.dart';
import 'package:chatapp/core/data/result.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthenticationRepository {
  AuthenticationRepository({
    required IAuthentication authenticationInterface,
    required UserDataAccessObject userDao,
  })  : _authenticationInterface = authenticationInterface,
        _userDao = userDao {
    _initializeBroadcast();
  }
  
  final IAuthentication _authenticationInterface;
  final UserDataAccessObject _userDao;

  late StreamController<UserModel?> _userController;
  Stream<UserModel?> get userSubscription => _userController.stream;

  void _initializeBroadcast() {
    _userController = StreamController<UserModel?>.broadcast();
  }

  UserModel get user {
    if (_authenticationInterface.authenticatedUser.isNotEmpty &&
        _userDao.userExists) {
      return _userDao.readUser();
    }
    return UserModel.empty;
  }

  Future<Result<void>> registerWithEmail(String email, String password) async {
    try {
      final response =
          await _authenticationInterface.registerWithEmail(email, password);
      final user = _authenticationInterface.authenticatedUser;
      if (user.isNotEmpty) {
        _userDao.writeUser(user);
        _userController.add(user);
      } else {
        return Result.failure(errorMessage: 'Google sign in failed.');
      }
      return Result.success(response);
    } catch (e) {
      return Result.failure(errorMessage: e.toString());
    }
  }

  Future<Result<void>> signInWithEmail(String email, String password) async {
    try {
      final response =
          await _authenticationInterface.signInEmail(email, password);
      final user = _authenticationInterface.authenticatedUser;
      if (user.isNotEmpty) {
        _userDao.writeUser(user);
        _userController.add(user);
      } else {
        return Result.failure(errorMessage: 'Google sign in failed.');
      }
      return Result.success(response);
    } catch (e) {
      return Result.failure(errorMessage: e.toString());
    }
  }

  Future<Result<void>> signInWithGithub() async {
    try {
      final response = await _authenticationInterface.signInGithub();
      final user = _authenticationInterface.authenticatedUser;
      if (user.isNotEmpty) {
        _userDao.writeUser(user);
        _userController.add(user);
      } else {
        return Result.failure(errorMessage: 'Google sign in failed.');
      }
      return Result.success(response);
    } catch (e) {
      return Result.failure(errorMessage: e.toString());
    }
  }

  Future<Result<void>> signInWithGoogle() async {
    try {
      final response = await _authenticationInterface.signInWithGoogle();
      final user = _authenticationInterface.authenticatedUser;

      if (user.isNotEmpty) {
        _userDao.writeUser(user);
        _userController.add(user);
      } else {
        return Result.failure(errorMessage: 'Google sign in failed.');
      }

      return Result.success(response);
    } catch (e) {
      return Result.failure(errorMessage: e.toString());
    }
  }

  Future<Result<void>> signOut() async {
    try {
      final response = await _authenticationInterface.signOut();
      _userDao.deleteUser();
      _userController.add(null);
      return Result.success(response);
    } catch (e) {
      return Result.failure(errorMessage: e.toString());
    }
  }

  void dispose() {
    _userController.close();
  }
}
