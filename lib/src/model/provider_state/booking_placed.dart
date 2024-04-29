import 'package:flutter/material.dart';

class BookingPlaced with ChangeNotifier{

  bool _isBookingPlaced = false;

  bool get isBookingPlaced => _isBookingPlaced;

  setIsBookingPlaced(bool value){

    _isBookingPlaced = value;
    notifyListeners();

  }

}