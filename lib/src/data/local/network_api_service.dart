import 'package:levitate/src/data/local/base_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkLocalService extends BaseLocalService{

  @override
  Future<void> setStringData(String setKey, String value) async{

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(setKey, value);

  }

  @override
  Future<void> setIntData(String setKey, int value) async{

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(setKey, value);

  }

  @override
  Future<void> setBoolData(String setKey, bool value) async {

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(setKey, value);

  }

  @override
  Future<void> setObjectListData(String setKey, List<String> value) async {

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList(setKey, value);

  }

  @override
  Future<dynamic> getStringData(String getKey) async{

    String data;

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? getData = pref.getString(getKey);

    // ignore: unnecessary_null_comparison
    if(getData.toString() == "null" || getData.toString() == null){

      data = "";

    }else{

      data = getData.toString();

    }

    return data;

  }

  @override
  Future getIntData(String getKey) async{

    int data;

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? getData = preferences.getInt(getKey);

    // ignore: unnecessary_null_comparison
    if(getData.toString() == "null" || getData.toString() == null){

      data = -1;

    }else{

      data = int.parse(getData.toString());

    }

    return data;

  }

  @override
  Future<dynamic> getBoolData(String getKey) async{

    bool data;

    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool? getData = pref.getBool(getKey);

    // ignore: unnecessary_null_comparison
    if(getData.toString() == "null" || getData.toString() == null){

      data = false;

    }else{

      data = bool.parse(getData.toString());

    }

    return data;

  }

  @override
  Future<dynamic> getObjectListData(String getKey) async {

    List<String> data;

    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? getData = pref.getStringList(getKey);

    // ignore: unnecessary_null_comparison
    if(getData == null){

      data = [];

    }else{

      data = getData;

    }

    return data;

  }

}