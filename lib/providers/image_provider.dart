import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/configs.dart';
import 'package:senia_app/models/response_model.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/http_tools.dart';

class ImagenProvider extends ChangeNotifier {
  BuildContext context;
  late UserProvider _userProvider;

  ImagenProvider({required this.context}) {
    this._userProvider = Provider.of<UserProvider>(this.context, listen: false);
  }

  Future<ResponseModel> loadImage(String letterId, String pathImage) async {
    try {
      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          pathImage,
          filename:
              pathImage.substring(pathImage.lastIndexOf('/'), pathImage.length),
        ),
      });
      final response = await dio.post(
          'https://${AppEnviroment.URL}${AppEnviroment.URL_PREENDPOINT}/${AppEnviroment.URL_ENDPOINT_IMAGE}/$letterId',
          data: formData,
          options: Options(
              contentType: "application/json",
              headers: {"token": _userProvider.token}));
      final resp = ResponseModel.fromJson(response.data);
      return resp;
    } on SocketException {
      return HttpTools.univiableServer;
    } on DioError catch (error) {
      return ResponseModel.fromJson(error.response!.data);
    }
  }
}
