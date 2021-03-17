import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario.internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario.internal();

  SharedPreferences prefs;

  initPrefts() async {
    prefs = await SharedPreferences.getInstance();
  }

  get colorSegundario => prefs.getBool('colorSegundario') ?? false;

  set colorSegundario(bool valor) => prefs.setBool('colorSegundario', valor);

}
