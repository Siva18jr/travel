import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/repository/places_repository.dart';

class PlacesViewModel with ChangeNotifier{

  final _myRepo = PlacesRepository();

  ApiResponse<List<PlacesModel>> _placeDataList = ApiResponse.loading();
  int _selectedIndex = -1;

  ApiResponse<List<PlacesModel>> get placeDataList => _placeDataList;
  int get selectedIndex => _selectedIndex;

  _setPlaceDataList(ApiResponse<List<PlacesModel>> data){

    _placeDataList = data;
    notifyListeners();

  }

  setSelectedIndex(int value){

    _selectedIndex = value;
    notifyListeners();

  }

  Future<void> fetchPlaceDataList() async{

    _setPlaceDataList(ApiResponse.loading());

    _myRepo.fetchPlacesData().then((value){

      _setPlaceDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setPlaceDataList(ApiResponse.error(error.toString()));

    });

  }

  Future<void> fetchPlaceDataListByCategory(String category) async{

    _setPlaceDataList(ApiResponse.loading());

    _myRepo.fetchPlacesDataByCategory(category).then((value){

      _setPlaceDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setPlaceDataList(ApiResponse.error(error.toString()));

    });

  }

  Future<void> searchPlaceDataList(String text) async{

    _setPlaceDataList(ApiResponse.loading());

    _myRepo.fetchPlacesData().then((value){

      value.retainWhere((element){

        String searchTerm = text.toLowerCase();
        String trimElement = element.title.toString().toLowerCase();
        bool textMatches = trimElement.contains(searchTerm);

        if(textMatches == true){

          return true;

        }

        if(text.isEmpty){

          return false;

        }

        String place = element.place.toString().toLowerCase();

        return place.contains(searchTerm);

      });

      log(value[0].title.toString());

      _setPlaceDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setPlaceDataList(ApiResponse.error(error.toString()));

    });

  }

}