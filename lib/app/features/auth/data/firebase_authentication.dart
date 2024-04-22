import 'package:chatapp/app/features/auth/data/authentication_interface.dart';
import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/core/utils/generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthentication)
class FirebaseAuthentication implements IAuthentication {
  FirebaseAuthentication({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore{
    _initAuthStateListener();
  }

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  User? _user;

  UserModel _authenticatedUser = UserModel.empty;

  void _initAuthStateListener() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      if (_user != null) {
        _authenticatedUser = UserModel(id: _user!.uid);
      }
    });
  }

  @override
  UserModel get authenticatedUser {
    if (_authenticatedUser.isEmpty || _user == null) {
      return UserModel.empty;
    }
    return _authenticatedUser;
  }

  @override
  Future<void> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      // TODO: check that mID has not been previously assigned to a user
      final mID = generateMID;
      if (firebaseUser != null) {
        _authenticatedUser = UserModel(
          id: _user?.uid ?? '',
          name: _user?.displayName,
          email: _user?.email,
          mID: mID,
          imageUrl: _user?.photoURL,
        );

        await _firebaseFirestore
            .collection('users')
            .doc(_user?.uid)
            .set(_authenticatedUser.toMap());
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInEmail(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCredential.user;
      final mID = generateMID;
      if (firebaseUser != null) {
        _authenticatedUser = UserModel(
          id: _user?.uid ?? '',
          name: _user?.displayName,
          email: _user?.email,
          mID: mID,
          imageUrl: _user?.photoURL,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInGithub() async {
    try {
      final githubProvider = GithubAuthProvider();
      await _firebaseAuth.signInWithProvider(githubProvider);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        final mID = generateMID;

        _authenticatedUser = UserModel(
          id: _user?.uid ?? '',
          name: _user?.displayName,
          email: _user?.email,
          mID: mID,
          imageUrl: _user?.photoURL,
        );

        await _firebaseFirestore
            .collection('users')
            .doc(_user?.uid)
            .set(_authenticatedUser.toMap());
      } else {
        final snapshot =
            await _firebaseFirestore.collection('users').doc(_user?.uid).get();
        final userMap = snapshot.data();
        _authenticatedUser = UserModel.fromMap(userMap!);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  String get generateMID => '${generatePrefixForID()}${generateSuffixForID(2)}';
}
