import 'package:flutter/material.dart';

class BudgetPredictionProvider with ChangeNotifier{

  double _distanceAmount = 0.0;
  double _totalBudget = 0.0;

  double get distanceAmount => _distanceAmount;
  double get totalBudget => _totalBudget;

  void setDistanceAmount(String value){

    _distanceAmount = double.parse(value) * 11;
    notifyListeners();

  }

  void setTotalBudget(double hotel, double others){

    _totalBudget = _distanceAmount + hotel + others;
    notifyListeners();

  }

}