import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier{

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  setIsSearching(bool value){

    _isSearching = value;
    notifyListeners();

  }

}