import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  String _appLanguage = AppPreference.appLanguage;

  void setAppLanguage(String lang) {
    _appLanguage = lang;
    notifyListeners();
  }

  Locale getAppLanguage() {
    return Locale(_appLanguage);
  }
}
