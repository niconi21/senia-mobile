import 'dart:convert';
import 'package:senia_app/configs/app_enviromets.dart';

class HttpTools {
  static Map<String, String> getHeaders({String token = ''}) {
    return {"Content-Type": "application/json", "token": token};
  }

  static Uri getUri(String path) =>
      Uri.http(AppEnviroment.URL, '${AppEnviroment.URL_PREENDPOINT}/$path');

  static String jsonEncode(Object value) => json.encode(value);
}
