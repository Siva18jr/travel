import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoModel with ChangeNotifier{

  String _packageVersionInfo = "";

  String get packageVersionInfo => _packageVersionInfo;

  _setPackageInfo(String value){

    _packageVersionInfo = value;
    notifyListeners();

  }

  Future<void> fetchPackageData() async{

    await PackageInfo.fromPlatform().then((value){

      _setPackageInfo(value.version);

    });

  }

}