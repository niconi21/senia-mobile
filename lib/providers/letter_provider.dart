import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:senia_app/configs/app_enviromets.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/http_tools.dart';

class LetterProvider extends ChangeNotifier {
  BuildContext context;
  late UserProvider userProvider;
  LetterProvider({required this.context}) {
    this.userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  List<LetterModel> _letters = [];
  List<LetterModel> get letters => _letters;
  set letters(List<LetterModel> letters) {
    this._letters = letters;
    notifyListeners();
  }

  Future<ResponseModel> getLetters() async {
    final response = await http.get(
        HttpTools.getUri(AppEnviroment.URL_ENDPOINT_LETTER),
        headers: HttpTools.getHeaders(token: userProvider.token));
    final resp = ResponseModel.fromJson(jsonDecode(response.body));

    if (resp.ok) {
      this.letters = resp.result.letters!;
    }
    return resp;
  }

  Future<ResponseModel> createLetter(LetterModel letter, String hand) async {
    final response =
        await http.post(HttpTools.getUri(AppEnviroment.URL_ENDPOINT_LETTER),
            headers: HttpTools.getHeaders(token: userProvider.token),
            body: HttpTools.jsonEncode({
              "letter": {
                "name": letter.name,
                "hand": hand,
                "type": "Entrenamiento",
              }
            }));
    final resp = ResponseModel.fromJson(jsonDecode(response.body));

    if (resp.ok) {
      this.getLetters();
    }
    return resp;
  }

  Future<ResponseModel> deleteLetter(String id) async {
    final response = await http.delete(
      HttpTools.getUri('${AppEnviroment.URL_ENDPOINT_LETTER}/$id'),
      headers: HttpTools.getHeaders(token: userProvider.token),
    );
    final resp = ResponseModel.fromJson(jsonDecode(response.body));

    if (resp.ok) {
      this.getLetters();
    }
    return resp;
  }
}
