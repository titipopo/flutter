import 'package:chatapp/app/features/auth/data/model/user_model.dart';

abstract class IAuthentication {
  UserModel get authenticatedUser;
  Future<void> registerWithEmail(String email, String password);
  Future<void> signInEmail(String email, String password);
  Future<void> signInGithub();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}
