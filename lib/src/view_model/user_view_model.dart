import 'package:levitate/src/repository/local_data_repository.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier{

  final _myRepo = LocalDataRepository();

  Future<bool> saveUser() async{

    _myRepo.setLocalBoolData(LocalKeys.localLoginBoolKey, true).then((value){

      return true;

    }).onError((error, stackTrace){

      return false;

    });

    return false;

  }

  Future<bool> remove() async{

    _myRepo.setLocalBoolData(LocalKeys.localLoginBoolKey, false).then((value){

      return true;

    }).onError((error, stackTrace){

      return false;

    });

    return false;

  }

}