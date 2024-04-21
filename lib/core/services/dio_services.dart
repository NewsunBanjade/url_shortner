import 'package:dio/dio.dart';
import 'package:vrit_project/core/config/app_url.dart';
import 'package:vrit_project/core/config/config.dart';

interface class IDioServices {
  Future<dynamic> postWithOutAuth(String path, dynamic data) async {}
  Future<dynamic> postWithAuth(String path, dynamic data) async {}
  Future<dynamic> getDataWithAuth(
    String path,
  ) async {}
  Future<dynamic> getDataWithOutAuth(
    String path,
  ) async {}
}

class DioServices implements IDioServices {
  late final Dio _dio;
  DioServices() {
    _dio = Dio()..options = BaseOptions(baseUrl: AppUrl.baseUrl);
  }

  @override
  Future<dynamic> getDataWithAuth(String path) async {
    try {
      return (await _dio.get(path, options: Options())).data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }

  @override
  Future<dynamic> getDataWithOutAuth(String path) async {
    try {
      return (await _dio.get(
        path,
      ))
          .data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }

  @override
  Future<dynamic> postWithAuth(String path, dynamic data) async {
    try {
      return (await _dio.post(path,
              data: data,
              options: Options(headers: {
                "Authorization": "Bearer ${Appconfig.accessToken}"
              })))
          .data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }

  @override
  Future<dynamic> postWithOutAuth(String path, dynamic data) async {
    try {
      return (await _dio.post(
        path,
        data: data,
      ))
          .data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }

  void handleDioError(DioException dioException) {
    if (dioException.response?.statusCode == 401) {
      throw ("Session Expire Please Login");
    }
    if (dioException.response?.statusCode != 200) {
      throw (dioException.response?.data.toString() ?? 'Server Error Occured');
    }

    final String error = switch (dioException.type) {
      DioExceptionType.connectionTimeout => 'Connection Timeout',
      DioExceptionType.sendTimeout => 'Request Timeout',
      DioExceptionType.receiveTimeout => 'Response Timeout',
      DioExceptionType.cancel => 'Connection was canceled',
      DioExceptionType.unknown =>
        (dioException.message?.contains('SocketException') ?? false)
            ? 'No Internet Connection or Server Offline'
            : dioException.toString(),
      _ => dioException.toString()
    };
    throw (error);
  }
}
