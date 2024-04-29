import 'package:hive/hive.dart';
import 'package:levitate/src/data/local/base_api_service.dart';
import 'package:levitate/src/data/local/network_api_service.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';

class FavouritesRepository{

  final BaseLocalService _localService = NetworkLocalService();
  final _cartBox = Hive.box(LocalKeys.favouritesDatabase);

  Future<dynamic> addFavouriteItemsApi(String key, dynamic value) async{

    try{

      dynamic response = await _localService.getDBPostApiResponse(LocalKeys.favouritesDatabase, key, value);
      return response;

    }catch (e){

      rethrow;

    }

  }

  Future<List<PlacesModel>> fetchFavouritesData() async{

    try{

      final data = _cartBox.keys.map((key){

        return PlacesModel.fromJson(_cartBox.get(key));

      }).toList();

      return data;

    }catch (e){

      rethrow;

    }

  }

  Future<bool> removeItemFromFavourites(String key) async{

    _cartBox.delete(key).then((value){

      return true;

    }).onError((error, stackTrace){

      return false;

    });

    return false;

  }

}