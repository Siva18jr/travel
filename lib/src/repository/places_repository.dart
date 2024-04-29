import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:levitate/src/data/local/base_api_service.dart';
import 'package:levitate/src/data/local/network_api_service.dart';
import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';

class PlacesRepository{

  final BaseApiService _apiService = NetworkApiService();
  final BaseLocalService _localService = NetworkLocalService();
  final _cartBox = Hive.box(LocalKeys.localServerDatabase);

  Future<List<PlacesModel>> fetchPlacesData() async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getApiResponse(DatabasePaths.placesPath);
      return response.docs.map((items) => PlacesModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

  Future<List<PlacesModel>> fetchPlacesDataByCategory(String category) async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getSelectedApiResponse("category", DatabasePaths.placesPath, category);
      return response.docs.map((items) => PlacesModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

  Future<dynamic> postPlacesData(dynamic data) async{

    try{

      //store data like map
      dynamic response = await _localService.getDBPostApiResponse(LocalKeys.localServerDatabase, LocalKeys.localPlaceKey, data);
      return response;

    }catch (e){

      rethrow;

    }

  }

  Future<List<PlacesModel>> fetchLocalHomeData() async{

    try{

      dynamic data = await _cartBox.get(LocalKeys.localPlaceKey);
      return data;

    }catch (e){

      rethrow;

    }

  }

  Future<bool> deleteLocalHomeData() async{

    _cartBox.delete(LocalKeys.localPlaceKey).then((value){

      return true;

    }).onError((error, stackTrace){

      return false;

    });

    return false;

  }

}