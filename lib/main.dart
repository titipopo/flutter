import 'package:chatapp/app.dart';
import 'package:chatapp/bloc_observer.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/src/bloc/auth_bloc.dart';
import 'package:chatapp/src/cubit/settings_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const WeatherBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
    BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(prefs: prefs)),
  ], child: const App()));
}
