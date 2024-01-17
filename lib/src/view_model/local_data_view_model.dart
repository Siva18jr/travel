import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/repository/local_data_repository.dart';
import 'package:flutter/material.dart';

class LocalDataViewModel with ChangeNotifier{

  final _myRepo = LocalDataRepository();

  ApiResponse<String> _localStringDataLoading = ApiResponse.loading();
  ApiResponse<int> _localIntDataLoading = ApiResponse.loading();
  ApiResponse<bool> _localBoolDataLoading = ApiResponse.loading();
  ApiResponse<dynamic> _localObjectListDataLoading = ApiResponse.loading();

  ApiResponse<String> get localStringData => _localStringDataLoading;
  ApiResponse<int> get localIntDataLoading => _localIntDataLoading;
  ApiResponse<bool> get loginBoolData => _localBoolDataLoading;
  ApiResponse<dynamic> get localObjectListDataLoading => _localObjectListDataLoading;

  _setLocalStringDataLoading(ApiResponse<String> value){

    _localStringDataLoading = value;
    notifyListeners();

  }

  _setLocalIntDataLoading(ApiResponse<int> value){

    _localIntDataLoading = value;
    notifyListeners();

  }

  _setLocalBoolDataLoading(ApiResponse<bool> value){

    _localBoolDataLoading = value;
    notifyListeners();

  }

  _setLocalObjectListDataLoading(ApiResponse<dynamic> value){

    _localObjectListDataLoading = value;
    notifyListeners();

  }

  Future<void> fetchStringDataList(String key) async{

    _setLocalStringDataLoading(ApiResponse.loading());

    _myRepo.fetchLocalStringData(key).then((value){

      _setLocalStringDataLoading(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setLocalStringDataLoading(ApiResponse.error(error.toString()));

    });

  }

  Future<void> fetchIntDataList(String key) async{

    _setLocalIntDataLoading(ApiResponse.loading());

    _myRepo.fetchLocalIntData(key).then((value){

      _setLocalIntDataLoading(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setLocalIntDataLoading(ApiResponse.error(error.toString()));

    });

  }

  Future<void> fetchBoolDataList(String key) async{

    _setLocalStringDataLoading(ApiResponse.loading());

    _myRepo.fetchLocalBoolData(key).then((value){

      _setLocalBoolDataLoading(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setLocalBoolDataLoading(ApiResponse.error(error.toString()));

    });

  }

  Future<void> fetchObjectListData(String key) async{

    _setLocalObjectListDataLoading(ApiResponse.loading());

    _myRepo.fetchLocalObjectData(key).then((value){

      _setLocalObjectListDataLoading(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setLocalObjectListDataLoading(ApiResponse.error(error.toString()));

    });

  }

}