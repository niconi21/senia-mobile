import 'package:flutter/foundation.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/tools/tools.dart';

class UiProvider extends ChangeNotifier {
  String _authPage = StringScreens.LoginScreen;
  String get authPage => _authPage;
  set authPage(String value) {
    _authPage = value;
    notifyListeners();
  }

  int _homePage = 1;
  int get homePage => _homePage;
  set homePage(int value) {
    _homePage = value;
    notifyListeners();
  }

  String _homePageName = StringScreens.lettersScreenName;
  String get homePageName => _homePageName;
  set homePageName(String value) {
    _homePageName = value;
    notifyListeners();
  }

  LetterModel _letterSelected = LetterModel.empty();
  LetterModel get letterSelected => _letterSelected;
  set letterSelected(LetterModel value) {
    if (value.name != _letterSelected.name) {
      _handSelected = '';
      _letterSelected = value;
    }
    notifyListeners();
  }

  String _handSelected = '';
  String get handSelected => _handSelected;
  set handSelected(String value) {
    this._handSelected = value;
    notifyListeners();
  }
}
