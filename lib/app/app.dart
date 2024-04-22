import 'package:chatapp/app/features/auth/ui/cubit/authentication_cubit.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/app/features/more/ui/cubit/settings_cubit.dart';
import 'package:chatapp/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key, required this.routers});

  final GoRouter routers;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (_, authState) {
          return
     BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Chat App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: state.locale,
            routerConfig: routers,
          );
        });});
  }
}
