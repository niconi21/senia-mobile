import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:senia_app/configs/app_enviromets.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/tools/tools.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel.empty();
  UserModel get user => this._user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  String _token = '';
  String get token => this._token;
  set token(String token) {
    this._token = token;
    notifyListeners();
  }

  Future<ResponseModel> login(String email) async {
    final response = await http.post(
        HttpTools.getUri('${AppEnviroment.URL_ENDPOINT_AUTH}/login'),
        headers: HttpTools.getHeaders(),
        body: HttpTools.jsonEncode({
          'user': {'correo': email}
        }));
    final resp = ResponseModel.fromJson(jsonDecode(response.body));
    if (resp.ok) {
      this.user = resp.result.user!;
      this.token = resp.result.token!;
    }
    return resp;
  }

  Future<ResponseModel> singup(String name, String email) async {
    final response = await http.post(
        HttpTools.getUri('${AppEnviroment.URL_ENDPOINT_AUTH}/registro'),
        headers: HttpTools.getHeaders(),
        body: HttpTools.jsonEncode({
          'user': {'nombre': name, 'correo': email}
        }));
    final resp = ResponseModel.fromJson(jsonDecode(response.body));
    return resp;
  }

  Future<ResponseModel> updateUser(String name, String email) async {
    final response =
        await http.put(HttpTools.getUri('${AppEnviroment.URL_ENDPOINT_USER}/'),
            headers: HttpTools.getHeaders(token: this.token),
            body: HttpTools.jsonEncode({
              'user': {'correo': email, 'nombre': name}
            }));

    print(response.body);
    final resp = ResponseModel.fromJson(jsonDecode(response.body));

    if (resp.ok) {
      this.user = resp.result.user!;
    }
    return resp;
  }

  Future<ResponseModel> deleteAccount() async {
    final response = await http.delete(
      HttpTools.getUri(AppEnviroment.URL_ENDPOINT_USER),
      headers: HttpTools.getHeaders(token: this._token),
    );
    final resp = ResponseModel.fromJson(jsonDecode(response.body));
    logout();
    return resp;
  }

  void logout() {
    this.user = UserModel.empty();
    this.token = '';
  }
}
