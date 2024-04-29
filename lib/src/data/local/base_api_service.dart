abstract class BaseLocalService{

  Future<void> setStringData(String setKey, String value);

  Future<void> setIntData(String setKey, int value);

  Future<void> setBoolData(String setKey, bool value);

  Future<void> setObjectListData(String setKey, List<String> value);

  Future<dynamic> getStringData(String getKey);

  Future<dynamic> getIntData(String getKey);

  Future<dynamic> getBoolData(String getKey);

  Future<dynamic> getObjectListData(String getKey);

  Future<dynamic> getDBPostApiResponse(String boxName, String key, dynamic value);

}