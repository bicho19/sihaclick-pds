import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:sihaclik/config.dart';
import 'package:sihaclik/utils/api_results.dart';

//TODO: change the return to ApiResults for God sake
class NetworkUtil {
  // or new Dio with a BaseOptions instance.
  BaseOptions options = new BaseOptions(
    baseUrl: Config.API_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio _dio;

  // next three lines makes this class a Singleton
  static NetworkUtil _instance = NetworkUtil.internal();
  JsonDecoder _decoder;

  NetworkUtil.internal() {
    _dio = Dio(options);
    _decoder = JsonDecoder();
  }

  factory NetworkUtil() => _instance;

  Future<ApiResult<dynamic>> get(String url,
      {int maxDays = 0, int maxHours = 0}) async {
    try {
      Options cacheOptions =
          buildCacheOptions(Duration(days: maxDays, hours: maxHours));
      Response response = await _dio.get(url, options: cacheOptions);
      //return data
      return ApiResult.completed(data: response.data);
    } on DioError catch (e) {
      //This should catch all network errors
      print(
          "########################## Dio Error #####################################");
      print("${e.type.toString()} : ${e.error}");
      print("${e.response}");

      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return ApiResult.error(
            message: "Connection timed out, please try again later");
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return ApiResult.error(
            message: "Response time out, please try again later");
      }
      if (e.type == DioErrorType.DEFAULT) {
        return ApiResult.error(message: "Error! please try again");
      }
      if (e.type == DioErrorType.RESPONSE) {
        // ...
        return ApiResult.fieldsError(message: "Error", data: e.response.data);
      }
    }
  }

  Future<ApiResult<dynamic>> post(String url, {Map headers, body}) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      //return the response data
      return ApiResult.completed(data: response.data);
    } on DioError catch (e) {
      //This should catch all the errors
      print(
          "########################## Dio Error #####################################");
      print("${e.type.toString()} : ${e.error}");
      print("${e.response}");
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        //TODO : properly implement connection timeout
        return ApiResult.error(
            message: "Connection timed out, please try again later");
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return ApiResult.error(
            message: "Response time out, please try again later");
      }
      if (e.type == DioErrorType.DEFAULT) {
        return ApiResult.error(message: "Error! please try again");
      }
      if (e.type == DioErrorType.RESPONSE) {
        // ...
        return ApiResult.fieldsError(message: "Error", data: e.response.data);
      }
    }
  }


  void setAuthenticationToken({String token}) {
    this._dio.options.headers["Authorization"] = "Bearer " + token;
  }

  void removeAuthentification() {
    this._dio.options.headers.remove("Authorization");
  }
}
