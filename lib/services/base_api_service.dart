import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinto/services/api_url.dart';

class BaseApiService {
  static final String url = ApiEndPoints.BASE_URL;

  static BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000);

  static Dio createDio() {
    return Dio(options);
  }

  static Dio addInterceptor(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onError: (error, errorInterceptorHandler) {
        print(error.message);
      }, onRequest: (request, requestInterceptorHandler) {
        return requestInterceptor(request);
      }, onResponse: (response, responseInterceptorHandler) {
        print('${response.statusCode} ${response.statusCode} ${response.data}');
      }

          // onRequest: (RequestOptions options) => requestInterceptor(options),
          // onError: (DioError e)async {
          //   print("ERROR HAPPENED: ${e.error}");
          //   return e.response.data;
          // }
          ));
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptor(dio);

  Future<Response> getHTTP(String url) async {
    try {
      Response response = await baseAPI.get(url);
      return response;
    } on DioError catch (e) {
      // Handle error
      print("in base api error: $e");
      throw e;
    }
  }

  Future<Response> postHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.post(url, data: data);
      print("respond:$response");
      return response;
    } on DioError catch (e) {
      print("error:e: ${e.error}");
      throw e.message;

      // Handle error
    }
  }

  Future<Response> putHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      print("error is : ${e.message}");
      throw e;
    }
  }

  Future<Response> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError catch (e) {
      // Handle error
      throw e;
    }
  }
}
