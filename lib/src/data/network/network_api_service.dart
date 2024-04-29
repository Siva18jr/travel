import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levitate/src/data/app_exceptions.dart';
import 'package:levitate/src/data/network/base_api_service.dart';

class NetworkApiService extends BaseApiService{

  @override
  Future getPostApiResponse(String path, dynamic data) async {

    try{

      final response = await FirebaseFirestore.instance.collection(path).add(data).timeout(
          const Duration(seconds: 10)
      );

      return response;

    }on SocketDirection{

      throw FetchDataException('No internet connection');

    }

  }

  @override
  Future<QuerySnapshot<Map<String,dynamic>>> getApiResponse(String path) async {

    try{

      dynamic response = await FirebaseFirestore.instance.collection(path).get().timeout(
          const Duration(seconds: 10)
      );
      return response;

    }on SocketDirection{

      throw FetchDataException('No internet connection');

    }

  }

  @override
  Future<QuerySnapshot<Map<String,dynamic>>> getSelectedApiResponse(String searchBy, String path, String getBy) async {

    try{

      dynamic response = await FirebaseFirestore.instance.collection(path).where(searchBy, isEqualTo: getBy).get().timeout(
          const Duration(seconds: 10)
      );
      return response;

    }on SocketDirection{

      throw FetchDataException('No internet connection');

    }

  }

  @override
  Future getPostWithKeyApiResponse(String path, String key, data) async {

    try{

      final response = await FirebaseFirestore.instance.collection(path).doc(key).set(data).timeout(
          const Duration(seconds: 10)
      );

      return response;

    }on SocketDirection{

      throw FetchDataException('No internet connection');

    }

  }

}