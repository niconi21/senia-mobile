import 'dart:convert';
import 'package:senia_app/configs/app_enviromets.dart';
import 'package:senia_app/models/models.dart';

class HttpTools {
  static Map<String, String> getHeaders({String token = '', contentType = "application/json"}) {
    return {"Content-Type": "application/json", "token": token};
  }

  static Uri getUri(String path) =>
      Uri.https(AppEnviroment.URL, '${AppEnviroment.URL_PREENDPOINT}/$path');

  static String jsonEncode(Object value) => json.encode(value);

  static final ResponseModel univiableServer = ResponseModel(
      ok: false,
      status: 500,
      message: 'No se pudo conectar con el servidor',
      result: ResultModel(),
      error: 'Intentelo nuevamente más tarde');
}
