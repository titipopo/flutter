import 'package:chatapp/app/features/more/data/model/settings_model.dart';

abstract class SettingsDataAccessObject {
  void writeSettings(SettingsModel authenticatedUser);
  void deleteSettings();
  SettingsModel readSettings();
}
