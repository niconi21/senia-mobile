import 'dart:convert';

import 'package:senia_app/models/models.dart';

class ResponseModel {
  final bool ok;
  final int status;
  final String message;
  final dynamic error;
  final ResultModel result;

  ResponseModel({
    required this.ok,
    required this.status,
    required this.message,
    required this.result,
    this.error = '',
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        ok: json['ok'],
        status: json['status'],
        message: json['message'],
        result: json['result'] != null
            ? ResultModel.fromJson(json['result'])
            : ResultModel(),
        error: json['error'],
      );
}

class ResultModel {
  ResultModel({this.token, this.user, List<LetterModel>? letters});

  String? token;
  UserModel? user;
  List<LetterModel>? letters = [];

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    final result = ResultModel(
      token: json["token"] != null ? json["token"] : '',
      user: json["user"] != null
          ? UserModel.fromJson(json["user"])
          : UserModel.empty(),
    );

    if (json['letters'] != null) {
      result.letters = List<LetterModel>.from(
          json['letters'].map((x) => LetterModel.fromJson(x)));

    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
      };
}
