import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/api_response.dart';
import 'package:levitate/src/model/api_models/booking_model.dart';
import 'package:levitate/src/repository/booking_repository.dart';

class BookingViewModel with ChangeNotifier{

  final BookingRepository _myRepo = BookingRepository();

  bool _bookingLoading = false;
  ApiResponse<List<BookingDataModel>> _bookedDataList = ApiResponse.loading();

  bool get bookingLoading => _bookingLoading;
  ApiResponse<List<BookingDataModel>> get bookedDataList => _bookedDataList;

  _setBookingLoading(bool value){

    _bookingLoading = value;
    notifyListeners();

  }

  _setBookedDataList(ApiResponse<List<BookingDataModel>> data){

    _bookedDataList = data;
    notifyListeners();

  }

  Future<void> postBookingDetailsApi(String key, dynamic data) async {

    _setBookingLoading(true);

    _myRepo.postBookingDetails(key, data).then((value){

      _setBookingLoading(false);

    }).onError((error, stackTrace){

      _setBookingLoading(false);

    });

  }

  Future<void> fetchBookedDataList(String key) async{

    _setBookedDataList(ApiResponse.loading());

    _myRepo.fetchBookingData(key).then((value){

      log(value[0].hotelName.toString());

      _setBookedDataList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      log(error.toString());

      _setBookedDataList(ApiResponse.error(error.toString()));

    });

  }

}