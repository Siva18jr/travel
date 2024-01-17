import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';

class UserRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> addUserData(dynamic data) async{

    try{

      dynamic response = await _apiService.getPostApiResponse(DatabasePaths.usersPath, data);
      return response;

    }catch(e){

      rethrow;

    }

  }

}