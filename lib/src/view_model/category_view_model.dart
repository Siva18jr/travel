import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/category_model.dart';
import 'package:levitate/src/repository/category_repository.dart';

class CategoryViewModel with ChangeNotifier{

  final _myRepo = CategoryRepository();

  ApiResponse<List<CategoryModel>> _categoryDataList = ApiResponse.loading();

  ApiResponse<List<CategoryModel>> get categoryDataList => _categoryDataList;

  _setPlaceDataList(ApiResponse<List<CategoryModel>> data){

    _categoryDataList = data;
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

}