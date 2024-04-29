import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levitate/src/data/network/base_api_service.dart';
import 'package:levitate/src/data/network/network_api_service.dart';
import 'package:levitate/src/model/api_models/booking_model.dart';
import 'package:levitate/src/res/data_urls/database_paths.dart';

class BookingRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> postBookingDetails(String key, dynamic data) async{

    try{

      dynamic response = await _apiService.getPostWithKeyApiResponse(DatabasePaths.bookingPath, key, data);
      return response;

    }catch (e){

      rethrow;

    }

  }

  Future<List<BookingDataModel>> fetchBookingData(String key) async{

    try{

      QuerySnapshot<Map<String,dynamic>> response = await _apiService.getSelectedApiResponse("u_id", DatabasePaths.bookingPath, key);
      return response.docs.map((items) => BookingDataModel.fromJson(items.data())).toList();

    }catch(e){

      rethrow;

    }

  }

}