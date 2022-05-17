class ImageModel {
  String id;
  DateTime craetedAt;
  String extension;

  ImageModel(
      {required this.id, required this.extension, required this.craetedAt});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['_id'] != null ? json['_id'] : '',
        extension: json['extension'] != null ? json['extension'] : '',
        craetedAt: json['craetedAt'] != null
            ? DateTime.parse(json['craetedAt'])
            : DateTime.now(),
      );
}
