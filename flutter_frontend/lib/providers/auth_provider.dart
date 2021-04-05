import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/services/auth_services.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  Future<User?>? _futureUser;
  late final storage;

  User? _user;

  AuthProvider() {
    storage = FlutterSecureStorage();
    initialData();
  }
  bool _isLoading = false;
  void triggerLoad() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  User? get user => _user;

  bool get isLoading => _isLoading;

  void initialData() async {
    var value = await (storage.read(key: 'token'));
    if (value != null) {
      _futureUser = getUserInfo(value);
      notifyListeners();
    }
  }

  void login(String username, String password) async {
    triggerLoad();
    Response? userdata = await AuthService().login(username, password);
    if (userdata != null) {
      bool isAuthenticate = userdata.data['success'] == 'true';
      if (isAuthenticate) {
        _futureUser = getUserInfo(userdata.data['token']);
        await storage.write(key: 'token', value: userdata.data['token']);
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: userdata.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    triggerLoad();
  }

  Future<bool> register(String username, String password) async {
    triggerLoad();
    Response? userdata = await AuthService().register(username, password);
    bool success = userdata?.data['success'];
    print(success);
    if (!success) {
      Fluttertoast.showToast(
          msg: userdata?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      triggerLoad();
      return false;
    } else {
      Fluttertoast.showToast(
          msg: userdata?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      triggerLoad();
      return true;
    }
  }

  Future<User?> getUserInfo(String? token) async {
    var res = await AuthService().getInfo(token);
    if (res!.data['success']) {
      var userData = User.fromJson(res.data);
      _user = userData;
      print(_user!.id);
      return userData;
    } else {
      return null;
    }
  }

  Future<User?>? get futureUser => _futureUser;

  void logout() {
    _futureUser = makeNull();
    _user = null;
    notifyListeners();
  }

  Future<User?> makeNull() async {
    await storage.deleteAll();
    return null;
  }
}
