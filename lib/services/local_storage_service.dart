import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageKeys {
  static const loggedIn = 'logged_in';
  static const userName = 'user_name';
  static const userEmail = 'user_email';
  static const userPassword = 'user_password';
  static const userPhotoPath = 'user_photo_path';
  static const themeMode = 'theme_mode';
  static const languageCode = 'language_code';
}

class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _prefs?.getBool(LocalStorageKeys.loggedIn) ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(LocalStorageKeys.loggedIn, value);
  }

  String? get userName => _prefs?.getString(LocalStorageKeys.userName);

  Future<void> setUserName(String name) async {
    await _prefs?.setString(LocalStorageKeys.userName, name);
  }

  String? get userEmail => _prefs?.getString(LocalStorageKeys.userEmail);

  Future<void> setUserEmail(String email) async {
    await _prefs?.setString(LocalStorageKeys.userEmail, email);
  }

  String? get userPassword => _prefs?.getString(LocalStorageKeys.userPassword);

  Future<void> setUserPassword(String password) async {
    await _prefs?.setString(LocalStorageKeys.userPassword, password);
  }

  String? get userPhotoPath =>
      _prefs?.getString(LocalStorageKeys.userPhotoPath);

  Future<void> setUserPhotoPath(String? path) async {
    if (path == null) {
      await _prefs?.remove(LocalStorageKeys.userPhotoPath);
    } else {
      await _prefs?.setString(LocalStorageKeys.userPhotoPath, path);
    }
  }

  String get themeMode => _prefs?.getString(LocalStorageKeys.themeMode) ?? 'light';

  Future<void> setThemeMode(String mode) async {
    await _prefs?.setString(LocalStorageKeys.themeMode, mode);
  }

  String get languageCode =>
      _prefs?.getString(LocalStorageKeys.languageCode) ?? 'ar';

  Future<void> setLanguageCode(String code) async {
    await _prefs?.setString(LocalStorageKeys.languageCode, code);
  }
}

