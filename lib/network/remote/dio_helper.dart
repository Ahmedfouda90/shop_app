import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      validateStatus: (status) {
        return status! < 500; // Consider status codes less than 500 as successful
      },
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getData({
    required String url,
  @  required Map<String, dynamic>? query,
    String? lang='en' ,
    String? token ,
  }) async {

      dio?.options.headers=
           {
             'Content-Type': 'application/json',
            'lang':'$lang',
            'Authorization':'$token'

          };

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String? url,
   String? lang='ar' ,
   String? token ,
    @required Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
  }) async {
    dio?.options.headers=
    {
      'Content-Type': 'application/json',
      'lang':'$lang',
      'Authorization':token??''
    };
    return dio!.post(url!, queryParameters: query, data: data);
  }
}
