import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FormGeneralProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  bool isChecked = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidFrom() {
    return formKey.currentState?.validate() ?? false;
  }
}
