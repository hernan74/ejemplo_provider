import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/db_provider.dart';
import 'package:flutter/material.dart ';

class PaginaProvider extends ChangeNotifier {
  int _pagina = 0;
  bool _seleccion = false;

  PageController _pageController = new PageController();

  int get paginaActual => _pagina;

  PageController get pageController => _pageController;

  set paginaActual(int pagina) {
    this._pagina = pagina;
    _pageController.animateToPage(_pagina,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    notifyListeners();
  }

  final List<UsuarioModel> _usuarioList = [];

  UsuarioModel _usuario = new UsuarioModel();

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

  void guardar() async {
    //Si seleccion es true modifica el registro
    if (_seleccion && _usuario.id != null) {
      await DBProvider.db.modificar(_usuario);
      _usuarioList.clear();
      _usuarioList.addAll(await DBProvider.db.buscarTodos());
    } else {
      _usuario.id = await DBProvider.db.crearNuevo(_usuario);
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
