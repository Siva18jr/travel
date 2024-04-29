import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/repository/favourites_repository.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/utils.dart';

class FavouritesViewModel with ChangeNotifier{

  final _myRepo = FavouritesRepository();

  ApiResponse<List<PlacesModel>> _favouritesDataList = ApiResponse.loading();
  bool _addToFavouritesLoading = false;

  ApiResponse<List<PlacesModel>> get favouritesDataList => _favouritesDataList;
  bool get addToFavouritesLoading => _addToFavouritesLoading;

  _setFavouritesDataList(ApiResponse<List<PlacesModel>> response){

    _favouritesDataList = response;
    notifyListeners();

  }

  _setAddToFavouritesLoading(bool value){

    _addToFavouritesLoading = value;
    notifyListeners();

  }

  Future<void> fetchMyFavouritesDataApi() async{

    _setFavouritesDataList(ApiResponse.loading());

    _myRepo.fetchFavouritesData().then((value){

      _setFavouritesDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      _setFavouritesDataList(ApiResponse.error("error : $error"));

    });

  }

  Future<void> addToFavouritesApi({required String key, required dynamic data, required BuildContext context}) async{

    _setAddToFavouritesLoading(true);

    _myRepo.addFavouriteItemsApi(key, data).then((value){

      Utils.toastMessage(
          message: "Added to Favourites",
          bgColor: AppColors.greenColor
      );

      fetchMyFavouritesDataApi();

      _setAddToFavouritesLoading(false);

    }).onError((error, stackTrace){

      _setAddToFavouritesLoading(false);

      Utils.flushBarMessage(
          title: "Error",
          message: error.toString(),
          context: context,
          bgColor: AppColors.redColor
      );

    });

  }

  Future<void> removeItemFromFavouritesAPi(String key) async{

    _myRepo.removeItemFromFavourites(key).then((value){

      fetchMyFavouritesDataApi();

      Utils.toastMessage(
          message: 'item removed',
          bgColor: AppColors.blackColor
      );

    });

  }

}