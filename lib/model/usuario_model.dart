import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel();

  int _id;
  String _usuario = '';
  String _email = '';
  String _direccion = '';
  int _edad ;

  int get id => this._id;

  String get usuario => this._usuario;

  String get direccion => this._direccion;

  String get email => this._email;

  int get edad => this._edad;

  set id(int id) {
    this._id = id;
  }

  set usuario(String usuario) {
    this._usuario = usuario;
  }

  set direccion(String direccion) {
    this._direccion = direccion;
  }

  set email(String email) {
    this._email = email;
  }

  set edad(int edad) {
    this._edad = edad;
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    final usuario = new UsuarioModel();
    usuario.id = json["id"];
    usuario.usuario = json["usuario"];
    usuario.email = json["email"];
    usuario.direccion = json["direccion"];
    usuario.edad = json["edad"];

    return usuario;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "email": email,
        "direccion": direccion,
        "edad": edad,
      };

      
}
