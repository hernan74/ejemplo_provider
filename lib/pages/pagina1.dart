import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ejemplo_provider/provider/preferencia_usuario.dart';
import 'package:ejemplo_provider/provider/theme_provider.dart';
import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';
import 'package:ejemplo_provider/widget/crear_snack.dart';

class Pagina1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final prefs = new PreferenciasUsuario();

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {
                final valor =
                    themeProvider.getTheme() == ThemeProvider.lightTheme;
                prefs.colorSegundario = valor;
                themeProvider.setTheme(
                    valor ? ThemeProvider.darkTheme : ThemeProvider.lightTheme);
              }),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                paginaProvider.borrarTodos();
              }),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: paginaProvider.usuarioList.length,
            itemBuilder: (_, i) {
              return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: _crearItem(context, i, paginaProvider.usuarioList[i]));
            }),
      ),
      floatingActionButton: _crearFloatingActionButton(context),
    );
  }

  Widget _crearItem(BuildContext context, int index, UsuarioModel model) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    //Escucha la selecciond de un item del ListView
    return GestureDetector(
      onTap: () {
        //Marca que se selecciono un usuario
        paginaProvider.seleccion = true;
        //Pasa al provider el usuario seleccionado
        paginaProvider.seleccionarUsuario(model);
        paginaProvider.paginaActual = 1;
      },
      child: _datosUsuario(context, model),
    );
  }

  Widget _datosUsuario(BuildContext context, UsuarioModel model) {
    final provider = Provider.of<PaginaProvider>(context);

    TextStyle style = TextStyle(
      color: provider.nuevoUsuario == model
          ? Theme.of(context).selectedRowColor
          : Theme.of(context).accentColor,
    );
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        provider.eliminar(model);

        mostrarSnackBar(context: context, msj: 'Usuario eliminado');
      },
      child: Card(
        color: provider.nuevoUsuario == model
            ? Theme.of(context).secondaryHeaderColor
            : Theme.of(context).cardColor,
        shape:
            (RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        child: ListTile(
          title: Text(
            'Usuario:${model.usuario} ',
            style: style,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Direccion:${model.direccion} ',
                style: style,
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'Email:${model.email} ',
                style: style,
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
          trailing: Column(
            children: <Widget>[
              SizedBox(
                height: 7.0,
              ),
              Text(
                'Edad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: provider.nuevoUsuario == model
                      ? Theme.of(context).selectedRowColor
                      : Theme.of(context).accentColor,
                ),
              ),
              Text(
                model.edad?.toString() ?? '',
                style: style,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearFloatingActionButton(BuildContext context) {
    final provider = Provider.of<PaginaProvider>(context);
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          provider.seleccionarUsuario(new UsuarioModel());
          provider.seleccion = false;
          provider.paginaActual=1;
        });
  }
}
