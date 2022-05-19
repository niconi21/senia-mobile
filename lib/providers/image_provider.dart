import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/http_tools.dart';

class ImagenProvider extends ChangeNotifier {
  BuildContext context;
  late UserProvider _userProvider;

  ImagenProvider({required this.context}) {
    this._userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  // Future loadImage() async {
  //   http.MultipartRequest('POST', Uri.parse('uri')).
  //   http.post(HttpTools.getUri('path'),
  //       headers: HttpTools.getHeaders(
  //           token: _userProvider.token, contentType: 'multipart/form-data'), encoding: Encoding.getByName('utf-8'));
            
  // }
}
