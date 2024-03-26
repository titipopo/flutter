import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/src/cubit/language_cubit.dart';
import 'package:chatapp/src/cubit/theme_cubit.dart';
import 'package:chatapp/src/routers/routers.dart';
import 'package:chatapp/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previousState, currentState) => previousState != currentState,
      builder: (context, state) {
        return BlocBuilder<LanguageCubit, LanguageState>(
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
            builder: (_, localeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Chat App',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: localeState.locale,
                onGenerateRoute: AppPages.generateRouterSettings,
              );
            });
      },
    );
  }
}
