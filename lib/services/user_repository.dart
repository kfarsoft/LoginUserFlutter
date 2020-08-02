import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterUser/services/preferences.dart';
import 'package:flutterUser/services/repository.dart';
import 'package:http/http.dart';

class UserRepository implements Repository {
  static final _prefs = Preferences();
  final baseUrl = 'http://10.0.2.2:3000';

  static Map<String, String> _securedHeaders = {
    'auth-token': '${_prefs.token}'
  };

  Future<void> authenticate({
    @required String email,
    @required String password,
  }) async {
    String url = '$baseUrl/auth/signin';

    Response response;
    Map body = {'email': '$email', 'password': '$password'};

    try {
      response = await post(url, body: body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final decodeResp = json.decode(response.body);
        if (decodeResp['status']) {
          _prefs.id = decodeResp['id'];
          _prefs.token = decodeResp['token'];
          _prefs.email = decodeResp['email'];
        }
      } else {
        throw 'Error';
      }
    } catch (e) {
      throw 'Error';
    }
  }

  Future<void> signUp(
      {@required String email, @required String password}) async {
    String url = '$baseUrl/auth/signup';

    Response response;
    Map body = {'email': '$email', 'password': '$password'};

    try {
      response = await post(url, body: body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final decodeResp = json.decode(response.body);
        if (decodeResp['status']) {
          _prefs.id = decodeResp['id'];
          _prefs.token = decodeResp['token'];
          _prefs.email = decodeResp['email'];
        }
      } else {
        throw 'Error';
      }
    } catch (e) {
      throw 'Error';
    }
  }

  void signOut() {
    _prefs.clear();
  }

  bool hasToken() {
    if (_prefs.token.toString().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getEmail() {
    return _prefs.email;
  }

  @override
  Future<bool> isAuthenticated() async {
    if (hasToken()) {
      String url = "$baseUrl/auth/hasToken";
      Response response;
      try {
        response = await post(url, headers: _securedHeaders);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final decodeResp = json.decode(response.body);
          if (decodeResp['status']) {
            return true;
          }
        } else {
          return false;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
    }
    return false;
  }
}
