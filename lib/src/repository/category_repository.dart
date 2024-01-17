import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/model/api_models/category_model.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';

class CategoryRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<List<CategoryModel>> fetchPlacesData() async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getApiResponse(DatabasePaths.categoryPath);
      return response.docs.map((items) => CategoryModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

}