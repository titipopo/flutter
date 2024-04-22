import 'package:chatapp/src/consts/const_strings.dart';
import 'package:chatapp/core/services/storage_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.prefs}) : super( const SettingsState()) {
    _loadSetting();
  }
  SharedPreferences prefs;

  void _loadSetting() async {
    bool? isDarkTheme =
        StorageManager.readData(prefs, SharedPreferencesKey.saveThemeModeKey);
    ThemeMode mode = isDarkTheme ?? false ? ThemeMode.dark : ThemeMode.light;

    String? strLocale =
        StorageManager.readData(prefs, SharedPreferencesKey.saveLanguageKey);
    Locale locale = const Locale('en');
    switch (strLocale) {
      case "en":
        locale = const Locale('en');
      case "vi":
        locale = const Locale('vi');
      case "jp":
        locale = const Locale('ja');
      default:
        locale = const Locale('en');
    }
    emit(state.copyWith(
      locale: locale,
      themeMode: mode,
    ));
  }

  void changeLanguage(String localeName) {
    switch (localeName) {
      case "en":
        StorageManager.saveData(prefs, SharedPreferencesKey.saveLanguageKey, 'en');
        emit(state.copyWith(locale: const Locale('en')));
      case "vi":
        StorageManager.saveData(prefs, SharedPreferencesKey.saveLanguageKey, 'vi');
        emit(state.copyWith(locale: const Locale('vi')));
      case "jp":
        StorageManager.saveData(prefs, SharedPreferencesKey.saveLanguageKey, 'jp');
        emit(state.copyWith(locale: const Locale('jp')));
    }
  }

  void toggleTheme({required bool isDarkTheme}) async {
    StorageManager.saveData(prefs, SharedPreferencesKey.saveThemeModeKey, isDarkTheme);
    emit(state.copyWith(
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light));
  }
}
