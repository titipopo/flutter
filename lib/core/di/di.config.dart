// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audioplayers/audioplayers.dart' as _i4;
import 'package:chatapp/app/features/auth/data/authentication_interface.dart'
    as _i13;
import 'package:chatapp/app/features/auth/data/authentication_repository.dart'
    as _i17;
import 'package:chatapp/app/features/auth/data/firebase_authentication.dart'
    as _i14;
import 'package:chatapp/app/features/auth/data/hive_user_dao.dart' as _i12;
import 'package:chatapp/app/features/auth/data/model/user_model.dart' as _i7;
import 'package:chatapp/app/features/auth/data/user_dao.dart' as _i11;
import 'package:chatapp/app/features/more/data/hive_settings_dao.dart' as _i16;
import 'package:chatapp/app/features/more/data/model/settings_model.dart'
    as _i8;
import 'package:chatapp/app/features/more/data/settings_dao.dart' as _i15;
import 'package:chatapp/core/di/module.dart' as _i18;
import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:firebase_storage/firebase_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:record/record.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.FirebaseStorage>(() => registerModule.firebaseStorage);
    gh.factory<_i4.AudioPlayer>(() => registerModule.audioPlayer);
    gh.factory<_i5.AudioRecorder>(() => registerModule.audioRecorder);
    await gh.factoryAsync<_i6.Box<_i7.UserModel>>(
      () => registerModule.userBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i6.Box<_i8.SettingsModel>>(
      () => registerModule.settingsBox,
      preResolve: true,
    );
    gh.singleton<_i9.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i10.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.singleton<_i11.UserDataAccessObject>(() =>
        _i12.HiveUserDataAccessObject(userBox: gh<_i6.Box<_i7.UserModel>>()));
    gh.singleton<_i13.IAuthentication>(() => _i14.FirebaseAuthentication(
          firebaseAuth: gh<_i9.FirebaseAuth>(),
          firebaseFirestore: gh<_i10.FirebaseFirestore>(),
        ));
    gh.singleton<_i15.SettingsDataAccessObject>(() =>
        _i16.HiveSettingsDataAccessObject(
            settingsBox: gh<_i6.Box<_i8.SettingsModel>>()));
    gh.singleton<_i17.AuthenticationRepository>(
        () => _i17.AuthenticationRepository(
              authenticationInterface: gh<_i13.IAuthentication>(),
              userDao: gh<_i11.UserDataAccessObject>(),
            ));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
