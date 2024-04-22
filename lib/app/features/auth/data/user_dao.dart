import 'package:chatapp/app/features/auth/data/model/user_model.dart';

abstract class UserDataAccessObject {
  void writeUser(UserModel authenticatedUser);
  void deleteUser();
  bool get userExists;
  UserModel readUser();
}
