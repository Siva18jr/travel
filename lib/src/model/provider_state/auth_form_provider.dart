import 'package:flutter/material.dart';

class AuthFormProvider with ChangeNotifier{

  String _selectedCountryValue = "";
  bool _isNameEmpty = false;
  bool _isMobileEmpty = false;
  bool _isEmailEmpty = false;
  bool _isMobileLoginEmpty = false;

  String get selectedCountryValue => _selectedCountryValue;
  bool get isNameEmpty => _isNameEmpty;
  bool get isMobileEmpty => _isMobileEmpty;
  bool get isEmailEmpty => _isEmailEmpty;
  bool get isMobileLoginEmpty => _isMobileLoginEmpty;

  setSelectedCountryValue(String value){

    _selectedCountryValue = value;
    notifyListeners();

  }

  setIsNameEmpty(bool value){

    _isNameEmpty = value;
    notifyListeners();

  }

  setIsMobileEmpty(bool value){

    _isMobileEmpty = value;
    notifyListeners();

  }

  setIsMobileLoginEmpty(bool value){

    _isMobileLoginEmpty = value;
    notifyListeners();

  }

  setIsEmailEmpty(bool value){

    _isEmailEmpty = value;
    notifyListeners();

  }

}