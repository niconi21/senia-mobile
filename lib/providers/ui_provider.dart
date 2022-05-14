import 'package:flutter/foundation.dart';
import 'package:senia_app/tools/tools.dart';

class UiProvider extends ChangeNotifier {
  String _authPage = StringScreens.LoginScreen;

  String get authPage => _authPage;
  set authPage(String value) {
    _authPage = value;
    notifyListeners();
  }
}
