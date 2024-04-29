abstract class BaseApiService{

  Future<dynamic> getApiResponse(String path);

  Future<dynamic> getSelectedApiResponse(String searchBy, String path, String getBy);

  Future<dynamic> getPostApiResponse(String path, dynamic data);

  Future<dynamic> getPostWithKeyApiResponse(String path,String key, dynamic data);

}