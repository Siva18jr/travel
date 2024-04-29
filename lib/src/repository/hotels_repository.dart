import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/model/api_models/hotels_model.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';

class HotelsRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<List<HotelsModel>> fetchHotelsData() async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getApiResponse(DatabasePaths.hotelsPath);
      return response.docs.map((items) => HotelsModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

  Future<List<HotelsModel>> fetchHotelsDataByDistrict(String district) async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getSelectedApiResponse("district", DatabasePaths.hotelsPath, district);
      return response.docs.map((items) => HotelsModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

}