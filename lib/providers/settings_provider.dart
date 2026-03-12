import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  String _languageCode = 'no';

  String get languageCode => _languageCode;

  void setLanguage(String code) {
    _languageCode = code;
    notifyListeners();
  }
}