import 'package:levitate/src/data/native/base_api_service.dart';
import 'package:levitate/src/data/native/network_api_service.dart';

class ShareData{

  final NativeBaseApiService _nativeBaseApiService = NativeApiService();

  shareData({required String shareHeader, required String title, required String subject}){

    _nativeBaseApiService.nativeShare(shareHeader, title, subject);

  }

}