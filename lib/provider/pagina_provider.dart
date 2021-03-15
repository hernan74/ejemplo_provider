import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/db_provider.dart';
import 'package:flutter/material.dart ';

class PaginaProvider extends ChangeNotifier {
  int _pagina = 0;
  bool _seleccion = false;

  final List<UsuarioModel> _usuarioList = [];

  UsuarioModel _usuario = new UsuarioModel();

  int get pagina => _pagina;

  UsuarioModel get nuevoUsuario => this._usuario;

  void cargarUsuarios() async {
    if (_usuarioList.isEmpty) {
      _usuarioList.addAll(await DBProvider.db.buscarTodos());
      print(_usuarioList.length);
      if (_usuarioList.isNotEmpty) notifyListeners();
    }
  }

  List<UsuarioModel> get usuarioList => _usuarioList;

  bool get seleccion => _seleccion;

  void modificar(UsuarioModel usuario) {
    _usuario = usuario;
  }

  set pagina(int pagina) {
    _pagina = pagina;
    notifyListeners();
  }

  set seleccion(bool seleccion) {
    _seleccion = seleccion;
    notifyListeners();
  }

  void eliminar() async {
    await DBProvider.db.borrarPorId(_usuario.id);
    _usuarioList.remove(_usuario);

    _seleccion = false;
    _usuario = new UsuarioModel();
    notifyListeners();
  }

  void guardar() async {
    //Si seleccion es true modifica el registro
    if (_seleccion && _usuario.id != null) {
      await DBProvider.db.modificar(_usuario);
      _usuarioList[_usuario.id] = _usuario;
    } else {
      await DBProvider.db.crearNuevo(_usuario);
      _usuarioList.add(_usuario);
    }

    _usuario = new UsuarioModel();
    _seleccion = false;
    _pagina = 0;
    notifyListeners();
  }

  void borrarTodos() async {
    await DBProvider.db.borrarTodos();
    _usuarioList.clear();
    notifyListeners();
  }
}
