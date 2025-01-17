import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreference {
  static SharedPreferences _sharedPreferences;

  static final String _authToken = "TOEKN";
  static final String _customerId = "_customerId";
  static final String _guestCartId = "_guestCartId";
  static final String _lastSearches = "_lastSearches";
  static final String _firebaseToken = "_firebaseToken";
  static final String _appLanguage = "appLanguage";
  static final String _defAddressID = "_defAddressID";

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static List<String> get lastSearches =>
      _sharedPreferences.getStringList(_lastSearches) ?? [];
  static set lastSearches(List<String> val) =>
      _sharedPreferences.setStringList(_lastSearches, val);

  static String get defAddressID =>
      _sharedPreferences.getString(_defAddressID) ?? "";
  static set defAddressID(String val) =>
      _sharedPreferences.setString(_defAddressID, val);

  static String get guestCartId =>
      _sharedPreferences.getString(_guestCartId) ?? "";
  static set guestCartId(String val) =>
      _sharedPreferences.setString(_guestCartId, val);

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
