import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show Colors, ChangeNotifier;
import 'package:flutter_frontend/models/post.dart';
import 'package:flutter_frontend/services/post_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostProvider with ChangeNotifier {
  Future<List<Post>> getAllPost() async {
    print('GetAll');
    Response? res = await PostService().getAllPost();
    if (res != null) {
      return (res.data as List).map((data) => Post.fromJson(data)).toList();
    } else {
      return res!.data;
    }
  }

  String _searchKey = '';

  String get searchKey => _searchKey;

  void search(String search) {
    _searchKey = search;
    notifyListeners();
  }

  Future<List<Post>> searchPost() async {
    print('search');
    Response? res = await PostService().searchPost(_searchKey);
    if (res != null) {
      return (res.data as List).map((data) => Post.fromJson(data)).toList();
    } else {
      return res!.data;
    }
  }

  Future<void> deletePost(String id) async {
    triggerLoad();
    Response? res = await PostService().deletePost(id);
    Fluttertoast.showToast(
      msg: res?.data['msg'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    triggerLoad();
  }

  void refresh() {
    notifyListeners();
  }

  Future<void> createPost(
    String title,
    String body,
    String author,
    String authorId,
  ) async {
    triggerLoad();
    Response? res =
        await PostService().createPost(title, body, author, authorId);
    Fluttertoast.showToast(
      msg: res?.data['msg'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    triggerLoad();
  }

  Future<void> updatePost(Post post) async {
    triggerLoad();
    Response? res = await PostService().updatePost(post);
    Fluttertoast.showToast(
      msg: res?.data['msg'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    triggerLoad();
  }

  bool _isLoading = false;
  void triggerLoad() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
