import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLanguage = Locale(AppPreference.appLanguage);

  void setAppLanguage(String lang) {
    _appLanguage = Locale(lang);
    notifyListeners();
  }

  Locale getAppLanguage() {
    return _appLanguage;
  }
}
