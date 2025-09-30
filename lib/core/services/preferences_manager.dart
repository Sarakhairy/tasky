import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static PreferencesManager _instance = PreferencesManager._internal();
  PreferencesManager._internal();
  factory PreferencesManager() => _instance;
  late final SharedPreferences _prefs;
  init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  String? getString(String key) => _prefs.getString(key);
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  remove(String key) => _prefs.remove(key);

}
