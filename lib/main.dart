import 'package:chatapp/app.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/src/screens/auth/bloc/authentication_bloc.dart';
import 'package:chatapp/src/cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(prefs: prefs)),
  ], child: const App()));
}
