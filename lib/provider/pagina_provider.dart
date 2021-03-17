import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/db_provider.dart';
import 'package:flutter/material.dart ';

class PaginaProvider extends ChangeNotifier {
  int _pagina = 0;
  bool _seleccion = false;

  PageController _pageController = new PageController();

  int get paginaActual => _pagina;

  final List<UsuarioModel> _usuarioList = [];

  UsuarioModel _usuario = new UsuarioModel();
  PageController get pageController => _pageController;

  set paginaActual(int pagina) {
    this._pagina = pagina;
    _pageController.animateToPage(_pagina,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    notifyListeners();
  }

  int get pagina => _pagina;

  UsuarioModel get nuevoUsuario => this._usuario;

  void cargarUsuarios() async {
    if (_usuarioList.isEmpty) {
      _usuarioList.addAll(await DBProvider.db.buscarTodos());
      if (_usuarioList.isNotEmpty) notifyListeners();
    }
  }

  List<UsuarioModel> get usuarioList => _usuarioList;

  bool get seleccion => _seleccion;

  void seleccionarUsuario(UsuarioModel usuario) {
    _usuario = usuario;
  }

  set seleccion(bool seleccion) {
    _seleccion = seleccion;
    notifyListeners();
  }

  void eliminar(UsuarioModel model) async {
    print(model.id);
    await DBProvider.db.borrarPorId(model.id);
    _usuarioList.remove(model);

    _seleccion = false;
    _usuario = new UsuarioModel();
    notifyListeners();
  }

  Future<bool> verificarEmail(String email) async {
    final res = await DBProvider.db.buscarPorEmail(email);
    return res == null ? false : true;
  }

  Future<dynamic> guardar() async {
    _usuarioList.clear();
    dynamic resp;
    if (_seleccion && _usuario.id != null) {
      resp = await DBProvider.db.modificar(_usuario);
    } else {
      resp = await DBProvider.db.crearNuevo(_usuario);
    }
    if (resp == true) {
      _usuario = new UsuarioModel();
      _seleccion = false;
      _pagina = 0;
    }

    return resp;
  }

  void borrarTodos() async {
    await DBProvider.db.borrarTodos();
    _usuarioList.clear();
    notifyListeners();
  }
}
