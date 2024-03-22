import 'package:chatapp/src/consts/const_strings.dart';
import 'package:chatapp/src/services/storage_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required this.prefs}) : super(ThemeMode.light) {
    _loadTheme();
  }

  SharedPreferences prefs;

  void _loadTheme() async {
    //bool isDarkTheme = StorageManager.getBool(prefs, ConstStrings.saveThemeModeKey) as bool;
    bool? isDarkTheme = prefs.getBool(ConstStrings.saveThemeModeKey)?? false;
    print('darkmode is $isDarkTheme');
    emit(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme({required bool isDarkTheme}) async {
    //prefs.setInt(ConstStrings.saveThemeModeKey, isDarkTheme ? 1: 0);
    StorageManager.saveData(prefs, ConstStrings.saveThemeModeKey, isDarkTheme);
    emit(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
    debugPrint('DarkModeCubit: $state');
  }
}

/*  void getCurrentTheme() {
    final themeString =
        StorageManager.readData(prefs, ConstStrings.saveThemeModeKey);
    if (themeString.toString() == ConstStrings.lightMode) {
      emit(state.copyWith(themeMode: _lightTheme));
    } else {
      emit(state.copyWith(themeMode: _darkTheme));
    }
  }

  static const _lightTheme = ThemeMode.light;

  static const _darkTheme = ThemeMode.dark;

  void toggleTheme() {
    StorageManager.saveData(
        prefs,
        ConstStrings.saveThemeModeKey,
        state.themeMode == _darkTheme
            ? ConstStrings.lightMode
            : ConstStrings.darkMode);
    emit(state.copyWith(
        themeMode: state.themeMode == _darkTheme ? _lightTheme : _darkTheme));
  }
}
*/