import 'package:flutter/foundation.dart';

class PurchaseProvider extends ChangeNotifier {
  bool _isPro = false;

  bool get isPro => _isPro;

  void unlockPro() {
    _isPro = true;
    notifyListeners();
  }

  void resetPro() {
    _isPro = false;
    notifyListeners();
  }
}