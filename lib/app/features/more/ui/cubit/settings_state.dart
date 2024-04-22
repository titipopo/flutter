part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.light,
  });

  final Locale locale;
  final ThemeMode themeMode;

  SettingsState copyWith(
          {Locale? locale, ThemeMode? themeMode}) =>
      SettingsState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object?> get props => [locale, themeMode];
}
