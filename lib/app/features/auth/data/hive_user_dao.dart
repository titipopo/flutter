import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/app/features/auth/data/user_dao.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserDataAccessObject)
class HiveUserDataAccessObject implements UserDataAccessObject {
  HiveUserDataAccessObject({
    required Box<UserModel> userBox,
  }) : _userBox = userBox;

  final Box<UserModel> _userBox;

  static const String _key = '__user__key__';

  @override
  UserModel readUser() {
    if (_userBox.isEmpty) {
      return UserModel.empty;
    }
    return _userBox.get(_key) ?? UserModel.empty;
  }

  @override
  void writeUser(UserModel authenticatedUser) =>
      _userBox.put(_key, authenticatedUser);

  @override
  void deleteUser() => _userBox.delete(_key);

  @override
  bool get userExists => _userBox.isNotEmpty;
}
