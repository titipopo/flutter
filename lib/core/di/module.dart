
import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/app/features/more/data/model/settings_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

@module
abstract class RegisterModule {
  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  AudioPlayer get audioPlayer => AudioPlayer();

  AudioRecorder get audioRecorder => AudioRecorder();

  @preResolve
  Future<Box<UserModel>> get userBox => Hive.openBox<UserModel>('userBox');
  
  @preResolve
  Future<Box<SettingsModel>> get settingsBox => Hive.openBox<SettingsModel>('settingsBox');
}
