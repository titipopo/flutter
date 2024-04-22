import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final UserMetadata? metadata;
  final String? lastSeen;
  final bool? isOnline;
  final String? token;
  UserModel({
    this.id,
    this.email,
    this.displayName,
    this.photoURL,
    this.metadata,
    this.lastSeen,
    this.isOnline,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
      id: data?['id'],
      email: data?['email'],
      displayName: data?['displayName'],
      photoURL: data?['photoURL'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (email != null) "email": email,
      if (displayName != null) "displayName": displayName,
      if (photoURL != null) "photoURL": photoURL,
    };
  }
}
