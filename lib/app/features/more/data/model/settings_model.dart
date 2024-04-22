import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsModel with EquatableMixin {
  @HiveField(0)
  final Locale? locale;

  @HiveField(1)
  final ThemeMode? themeMode;

  const SettingsModel({
    this.locale,
    this.themeMode,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
        locale: map['locale'] as Locale,
        themeMode: map['themeMode'] as ThemeMode,
      );

  Map<String, dynamic> toMap() {
    return {
      'locale': locale,
      'themeMode': themeMode,
    };
  }

  static const empty = SettingsModel();
  bool get isEmpty => this == SettingsModel.empty;
  bool get isNotEmpty => this != SettingsModel.empty;

  @override
  List<Object?> get props => [locale, themeMode];
}
