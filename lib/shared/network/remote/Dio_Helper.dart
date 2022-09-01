import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {'content': 'application/json', 'lang': 'en'},
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdata(
      {required String url,
      Map<String, dynamic>? query,
      lang = 'en',
      token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    lang = 'en',
    token,
    query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic>? data,
    lang = 'en',
    token,
    query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.put(url, queryParameters: query, data: data);
  }

  static Future<String?> uploadImage(
    file,
    url,
    token,
  ) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    dio.post(url, data: data).then((response) {
      print("respons$response");
      return response;
    }).catchError((error) => print(error));
  }
}
