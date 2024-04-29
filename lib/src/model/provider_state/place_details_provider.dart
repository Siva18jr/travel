import 'package:flutter/material.dart';

class PlaceDetailsProvider with ChangeNotifier{

  int _selectedIndex = -1;
  int _selectedHotelPrice = -1;
  int _totalAmount = 0;
  String _selectedHotel = "";
  String _selectedDate = "";

  int get selectedIndex => _selectedIndex;
  int get selectedHotelPrice => _selectedHotelPrice;
  int get totalAmount => _totalAmount;
  String get selectedHotel => _selectedHotel;
  String get selectedDate => _selectedDate;

  setSelectedIndex(int value){

    _selectedIndex = value;
    notifyListeners();

  }

  setSelectedHotelPrice(int value){

    _selectedHotelPrice = value;
    notifyListeners();

  }

  setTotalAmount(){

    _totalAmount = _selectedHotelPrice * (_selectedIndex + 1);
    notifyListeners();

  }

  setSelectedHotel(String value){

    _selectedHotel = value;
    notifyListeners();

  }

  setSelectedDate(String value){

    _selectedDate = value;
    notifyListeners();

  }

}