import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreference {
  static SharedPreferences _sharedPreferences;

  static final String _authToken = "TOEKN";
  static final String _customerId = "_customerId";
  static final String _firebaseToken = "_firebaseToken";
  static final String _appLanguage = "appLanguage";

  static Future<void> init() async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String get firebaseToken =>
      _sharedPreferences.getString(_firebaseToken) ?? "";
  static set firebaseToken(String val) =>
      _sharedPreferences.setString(_firebaseToken, val);

  static String get customerId => _sharedPreferences.getString(_customerId);
  static set customerId(String val) =>
      _sharedPreferences.setString(_customerId, val);

  static String get token => _sharedPreferences.getString(_authToken);
  static set token(String val) => _sharedPreferences.setString(_authToken, val);

  static String get appLanguage =>
      _sharedPreferences.getString(_appLanguage) ?? "en";
  static set appLanguage(String val) =>
      _sharedPreferences.setString(_appLanguage, val);
}
