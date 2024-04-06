import 'dart:convert';

import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static String kIsLogin = 'isLogin';
  static String kFcmToken = 'FCM_TOKEN';

  set fcmToken(String value) => _sharedPreferences.setString(kFcmToken, value);
  String get fcmToken => _sharedPreferences.getString(kFcmToken) ?? '';

  set isLogin(bool value) => _sharedPreferences.setBool(kIsLogin, value);
  bool get isLogin => _sharedPreferences.getBool(kIsLogin) ?? false;

  static String kToken = 'token';
  set token(String value) => _sharedPreferences.setString(kToken, value);
  String get token => _sharedPreferences.getString(kToken) ?? '';

  static String kUser = 'user';
  Future<bool> setUser(User user) =>
      _sharedPreferences.setString(kUser, json.encode(user.toJson()));
  User get user {
    final userString = _sharedPreferences.getString(kUser) ?? '';
    if (userString.isNotEmpty) {
      return User.fromJson(
        json.decode(userString) as Map<String, dynamic>,
      );
    }
    return User.empty();
  }

  void clear() => _sharedPreferences.clear();
}
