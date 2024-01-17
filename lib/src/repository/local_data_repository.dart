import 'package:levitate/src/data/local/base_api_service.dart';
import 'package:levitate/src/data/local/network_api_service.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';
import 'package:levitate/src/utils/utils.dart';

class LocalDataRepository{

  final BaseLocalService _localService = NetworkLocalService();

  Future<void> setLocalStringData(String key, String value) async{

    try{

      await _localService.setStringData(key, value);

    }catch(e){

      Utils.toastMessage(
          message: 'Something went wrong',
          bgColor: AppColors.blackColor
      );
      rethrow;

    }

  }

  Future<void> setLocalIntData(String key, int value) async{

    try{

      await _localService.setIntData(key, value);

    }catch(e){

      Utils.toastMessage(
          message: 'Something went wrong',
          bgColor: AppColors.blackColor
      );
      rethrow;

    }

  }

  Future<void> setLocalBoolData(String key, bool value) async{

    try{

      await _localService.setBoolData(key, value);

    }catch(e){

      Utils.toastMessage(
          message: 'Something went wrong',
          bgColor: AppColors.blackColor
      );

      rethrow;

    }

  }

  Future<void> setLocalObjectListData(String key, List<String> value) async{

    try{

      await _localService.setObjectListData(key, value);

    }catch(e){

      Utils.toastMessage(
          message: 'Something went wrong',
          bgColor: AppColors.blackColor
      );

      rethrow;

    }

  }

  Future<String> fetchLocalStringData(String key) async{

    try{

      dynamic response = await _localService.getStringData(key);
      return response;

    }catch(e){

      rethrow;

    }

  }

  Future<int> fetchLocalIntData(String key) async{

    try{

      dynamic response = await _localService.getIntData(key);
      return response;

    }catch(e){

      rethrow;

    }

  }

  Future<bool> fetchLocalBoolData(String key) async{

    try{

      dynamic response = await _localService.getBoolData(LocalKeys.localLoginBoolKey);
      return response;

    }catch(e){

      rethrow;

    }

  }

  Future<dynamic> fetchLocalObjectData(String key) async{

    try{

      dynamic response = await _localService.getObjectListData(key);
      return response;

    }catch(e){

      rethrow;

    }

  }


}