import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/hotels_model.dart';
import 'package:levitate/src/repository/hotels_repository.dart';

class HotelsViewModel with ChangeNotifier{

  final HotelsRepository _myRepo = HotelsRepository();

  ApiResponse<List<HotelsModel>> _hotelsDataList = ApiResponse.loading();
  final List<String> _hotelsInfo = [];
  final List<String> _hotelsPrice = [];

  ApiResponse<List<HotelsModel>> get hotelsDataList => _hotelsDataList;
  List<String> get hotelsInfo => _hotelsInfo;
  List<String> get hotelsPrice => _hotelsPrice;

  _setHotelsDataList(ApiResponse<List<HotelsModel>> data){

    _hotelsDataList = data;
    notifyListeners();

  }

  Future<void> fetchHotelsDataList() async{

    _setHotelsDataList(ApiResponse.loading());

    _myRepo.fetchHotelsData().then((value){

      _setHotelsDataList(ApiResponse.completed(value));

      log(value.toString());

    }).onError((error, stackTrace){

      _setHotelsDataList(ApiResponse.error(error.toString()));

    });

  }

  Future<void> fetchHotelsDataByDistrictAPI(String district) async{

    _setHotelsDataList(ApiResponse.loading());

    _myRepo.fetchHotelsDataByDistrict(district).then((value){

      for(int i=0; i<value[0].hotels!.length; i++){

        _hotelsInfo.add(value[0].hotels![i].name.toString());
        _hotelsPrice.add(value[0].hotels![i].price.toString());

      }

      _setHotelsDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setHotelsDataList(ApiResponse.error(error.toString()));

    });

  }

}