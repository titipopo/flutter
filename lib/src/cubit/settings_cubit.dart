import 'package:chatapp/src/consts/const_strings.dart';
import 'package:chatapp/src/services/storage_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.prefs}) : super(const SettingsState()) {
    _loadSetting();
  }
  SharedPreferences prefs;

  void _loadSetting() async {
    bool? isDarkTheme =
        StorageManager.readData(prefs, ConstStrings.saveThemeModeKey);
    ThemeMode mode = isDarkTheme ?? false ? ThemeMode.dark : ThemeMode.light;

    String? strLocale =
        StorageManager.readData(prefs, ConstStrings.saveLanguageKey);
    Locale locale = const Locale('en');
    switch (strLocale) {
      case "en":
        locale = const Locale('en');
      case "vi":
        locale = const Locale('vi');
      case "jp":
        locale = const Locale('jp');
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
        StorageManager.saveData(prefs, ConstStrings.saveLanguageKey, 'en');
        emit(state.copyWith(locale: const Locale('en')));
      case "vi":
        StorageManager.saveData(prefs, ConstStrings.saveLanguageKey, 'vi');
        emit(state.copyWith(locale: const Locale('vi')));
      case "jp":
        StorageManager.saveData(prefs, ConstStrings.saveLanguageKey, 'jp');
        emit(state.copyWith(locale: const Locale('jp')));
    }
  }

  void toggleTheme({required bool isDarkTheme}) async {
    StorageManager.saveData(prefs, ConstStrings.saveThemeModeKey, isDarkTheme);
    emit(state.copyWith(
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light));
  }
}
