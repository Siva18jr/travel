abstract class BaseApiService{

  Future<dynamic> getApiResponse(String path);

  Future<dynamic> getSelectedApiResponse(String path, String getBy);

  Future<dynamic> getPostApiResponse(String path, dynamic data);

}