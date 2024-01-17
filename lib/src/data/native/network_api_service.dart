import 'dart:developer';

import 'package:levitate/src/data/native/base_api_service.dart';
import 'package:flutter/services.dart';

class NativeApiService extends NativeBaseApiService{

  static const platform = MethodChannel("flutter.native/helper");

  @override
  Future<void> nativeShare(String shareHeader, String title, String subject) async {

    try {

      final String result = await platform.invokeMethod("share_data", {
        "share_header": shareHeader,
        "title": title,
        "subject": subject
      });

      log(result);

    } on PlatformException catch (e) {

      log(e.toString());

    }

  }

}