import 'package:chatapp/app/app.dart';
import 'package:chatapp/app/features/auth/data/authentication_repository.dart';
import 'package:chatapp/app/features/auth/data/model/user_model.dart';
import 'package:chatapp/app/features/auth/ui/cubit/authentication_cubit.dart';
import 'package:chatapp/app/features/more/data/model/settings_model.dart';
import 'package:chatapp/bloc_observer.dart';
import 'package:chatapp/core/di/di.dart';
import 'package:chatapp/core/navigation/app_routers.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/app/features/more/ui/cubit/settings_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await setup();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  GoRouter routers = AppRoutes.getRouters(0);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationCubit>(
        create: (_) => AuthenticationCubit(
            authenticationRepository: locator<AuthenticationRepository>(),
            routers: routers)),
    BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(prefs: prefs)),
  ], child: App(routers: routers)));
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, '.db.hive');
  await Hive.initFlutter(dbPath);

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  await initDependencies();
}
