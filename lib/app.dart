import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/cubit/settings_cubit.dart';
import 'package:chatapp/src/routers/routers.dart';
import 'package:chatapp/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: state.locale,
            onGenerateRoute: AppPages.generateRouterSettings,
          );
        });
  }
}
