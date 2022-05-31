import 'package:senia_app/models/models.dart';

class LetterModel {
  String id;
  String name;
  String type;
  String hand;
  double percentage;
  DateTime createdAt;
  List<ImageModel> images;
  List<LetterModel> types;
  List<LetterModel> hands;
  String image;

  UserModel user = UserModel.empty();
  LetterModel({
    required this.id,
    required this.name,
    required this.type,
    required this.hand,
    required this.percentage,
    required this.createdAt,
    required this.images,
    required this.types,
    required this.hands,
    required this.image,
  });

  factory LetterModel.fromJson(Map<String, dynamic> json) => LetterModel(
      id: json['_id'] != null ? json['_id'] : '',
      name: json['name'] != null ? json['name'] : '',
      type: json['type'] != null ? json['type'] : '',
      hand: json['hand'] != null ? json['hand'] : '',
      percentage:
          json['percentage'] != null ? json['percentage'].toDouble() : 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      images: json['images'] != null
          ? List<ImageModel>.from(
              json['images'].map((x) => ImageModel.fromJson(x)))
          : [],
      types: json['types'] != null
          ? List<LetterModel>.from(
              json['types'].map((x) => LetterModel.fromJson(x)))
          : [],
      hands: json['hands'] != null
          ? List<LetterModel>.from(
              json['hands'].map((x) => LetterModel.fromJson(x)))
          : [],
      image: 'assets/logo.png');

  factory LetterModel.empty() => LetterModel(
      id: 'Sin ID',
      name: '',
      type: 'Sin tipo',
      hand: 'Sin mano',
      percentage: 0,
      createdAt: DateTime.now(),
      images: [],
      types: [],
      hands: [],
      image: 'assets/logo.png');

  factory LetterModel.name({
    required String name,
    required String image,
  }) =>
      LetterModel(
          id: 'Sin ID',
          name: name,
          type: 'Sin tipo',
          hand: 'Sin mano',
          percentage: 0,
          createdAt: DateTime.now(),
          images: [],
          types: [],
          hands: [],
          image: image);

  factory LetterModel.nameAndHand(
          {required String name,
          required String hand,
          required String image}) =>
      LetterModel(
          id: 'Sin ID',
          name: name,
          type: 'Sin tipo',
          hand: hand,
          percentage: 0,
          createdAt: DateTime.now(),
          images: [],
          types: [],
          hands: [],
          image: image);
}
