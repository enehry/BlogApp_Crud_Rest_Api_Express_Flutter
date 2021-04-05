import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = Dio();

  Future<Response?> login(String username, String password) async {
    try {
      return await dio.post('https://nehryrestapi.herokuapp.com/authenticate',
          data: {'name': username, 'password': password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (ex) {
      return ex.response;
    }
  }

  Future<Response?> getInfo(String? token) async {
    try {
      return await dio.get('https://nehryrestapi.herokuapp.com/getinfo',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } on DioError catch (ex) {
      return ex.response;
    }
  }

  Future<Response?> register(String username, String password) async {
    try {
      return await dio.post('https://nehryrestapi.herokuapp.com/adduser',
          data: {'name': username, 'password': password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (ex) {
      return ex.response;
    }
  }
}
