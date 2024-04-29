import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier{

  bool _fromServer = false;

  bool get fromServer => _fromServer;

  setFromServer(bool value){

    _fromServer = value;
    notifyListeners();

  }

}