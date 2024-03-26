import 'package:chatapp/src/consts/const_strings.dart';
import 'package:chatapp/src/services/storage_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({required this.prefs})
      : super(const LanguageInitial(Locale('en'))) {
    _loadLanguage();
  }

  SharedPreferences prefs;

  void _loadLanguage() async {
    String? strLocale = prefs.getString(ConstStrings.saveLanguageKey) ?? "";
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
    emit(LanguageInitial(locale));
  }

  void toVietNamese() {
    StorageManager.saveData(prefs, ConstStrings.saveThemeModeKey, 'vi');
    emit(const LanguageInitial(Locale('vi')));
  }

  void toJapanese() {
    StorageManager.saveData(prefs, ConstStrings.saveThemeModeKey, 'jp');
    emit(const LanguageInitial(Locale('jp')));
  }

  void toEnglish() {
    StorageManager.saveData(prefs, ConstStrings.saveThemeModeKey, 'en');
    emit(const LanguageInitial(Locale('en')));
  }
}
