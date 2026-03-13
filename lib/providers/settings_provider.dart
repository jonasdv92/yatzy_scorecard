import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  String _languageCode = 'no';

  String get languageCode => _languageCode;

  bool get isEnglish => _languageCode == 'en';
  bool get isNorwegian => _languageCode == 'no';

  void setLanguage(String code) {
    _languageCode = code;
    notifyListeners();
  }
}