import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/category_model.dart';
import 'package:levitate/src/repository/category_repository.dart';

class CategoryViewModel with ChangeNotifier{

  final _myRepo = CategoryRepository();

  ApiResponse<List<CategoryModel>> _categoryDataList = ApiResponse.loading();

  ApiResponse<List<CategoryModel>> get categoryDataList => _categoryDataList;

  _setCategoryDataList(ApiResponse<List<CategoryModel>> data){

    _categoryDataList = data;
    notifyListeners();

  }

  Future<void> fetchCategoryDataList() async{

    _setCategoryDataList(ApiResponse.loading());

    _myRepo.fetchPlacesData().then((value){

      _setCategoryDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setCategoryDataList(ApiResponse.error(error.toString()));

    });

  }

}