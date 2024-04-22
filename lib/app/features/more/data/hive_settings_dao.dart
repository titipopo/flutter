import 'package:chatapp/app/features/more/data/model/settings_model.dart';
import 'package:chatapp/app/features/more/data/settings_dao.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SettingsDataAccessObject)
class HiveSettingsDataAccessObject implements SettingsDataAccessObject {
  HiveSettingsDataAccessObject({
    required Box<SettingsModel> settingsBox,
  }) : _settingsBox = settingsBox;

  final Box<SettingsModel> _settingsBox;

  static const String _key = '__settings__key__';

  @override
  SettingsModel readSettings() {
    if (_settingsBox.isEmpty) {
      return SettingsModel.empty;
    }
    return _settingsBox.get(_key) ?? SettingsModel.empty;
  }

  @override
  void writeSettings(SettingsModel authenticatedUser) =>
      _settingsBox.put(_key, authenticatedUser);

  @override
  void deleteSettings() => _settingsBox.delete(_key);
}
