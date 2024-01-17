import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';

class PlacesRepository{

  final BaseApiService _apiService = NetworkApiService();

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

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getSelectedApiResponse(DatabasePaths.placesPath, category);
      return response.docs.map((items) => PlacesModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

}