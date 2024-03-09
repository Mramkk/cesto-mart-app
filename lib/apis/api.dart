import 'package:dio/dio.dart';
import 'package:cesto_mart/config/urls.dart';

class Api {
  Dio dio = Dio();
  Api() {
    dio.options.baseUrl = "${baseUrl}api";
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Dio get sendRequest => dio;
}
