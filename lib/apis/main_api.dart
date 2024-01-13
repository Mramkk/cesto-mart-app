import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cesto_mart/apis/api.dart';
import 'package:cesto_mart/apis/http_response.dart';

class MainApi {
  Api api = Api();

  Future<HttpRes> getData({
    required String subUrl,
    required Map<String, dynamic> query,
  }) async {
    try {
      Response response = await api.sendRequest.get(
        subUrl,
        queryParameters: query,
      );

      Map res = response.data;

      if (response.statusCode == 200) {
        return HttpRes(res['status'], res['data'], message: res['message']);
      } else {
        return HttpRes(res['status'], [], message: res['message']);
      }
    } on SocketException {
      return HttpRes(false, [], message: "No Internet Connection");
    } on TimeoutException {
      return HttpRes(false, [], message: "Request Timeout");
    } catch (e) {
      print(e);
      return HttpRes(false, [], message: e.toString());
    }
  }

  Future<HttpRes> setData({
    required String subUrl,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await api.sendRequest.post(
        subUrl,
        data: jsonEncode(data),
      );

      Map res = response.data;

      if (response.statusCode == 200) {
        return HttpRes(res['status'], res, message: res['message']);
      } else {
        return HttpRes(res['status'], [], message: res['message']);
      }
    } on SocketException {
      return HttpRes(false, [], message: "No Internet Connection");
    } on TimeoutException {
      return HttpRes(false, [], message: "Request Timeout");
    } catch (e) {
      return HttpRes(false, [], message: e.toString());
    }
  }

  Future<HttpRes> uploadDocument({
    required String subUrl,
    required File file,
  }) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "document": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    try {
      Response response = await api.sendRequest.post(subUrl, data: data);

      Map res = response.data;
      if (response.statusCode == 200) {
        return HttpRes(res['status'], res, message: res['message']);
      } else {
        return HttpRes(res['status'], res, message: res['message']);
      }
    } on SocketException {
      return HttpRes(false, [], message: "No Internet Connection");
    } on TimeoutException {
      return HttpRes(false, [], message: "Request Timeout");
    } catch (e) {
      return HttpRes(false, [], message: e.toString());
    }
  }
}
