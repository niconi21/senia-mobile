class UserModel {
  UserModel({
    required this.nombre,
    required this.correo,
    required this.role,
    required this.isGoogle,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  String id;
  String nombre;
  String correo;
  String role;
  bool isGoogle;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"] != null ? json["_id"] : '',
        nombre: json["nombre"] != null ? json["nombre"] : '',
        correo: json["correo"] != null ? json["correo"] : '',
        role: json["role"] != null ? json["role"] : '',
        isGoogle: json["isGoogle"] != null ? json["isGoogle"] : false,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
      );

  factory UserModel.empty() => UserModel(
        nombre: 'Sin nombre',
        correo: "Sin correo",
        role: "Sin role",
        isGoogle: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: 'Sin ID',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "correo": correo,
        "role": role,
        "isGoogle": isGoogle,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
