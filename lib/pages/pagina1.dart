import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pagina1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context, listen: false);

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
          itemCount: paginaProvider.usuarioList.length,
          itemBuilder: (_, i) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: _crearItem(context, i, paginaProvider.usuarioList[i]));
          }),
    );
  }

  Widget _crearItem(BuildContext context, int index, UsuarioModel model) {
    model.id = index;

    final paginaProvider = Provider.of<PaginaProvider>(context);
    //Escucha la selecciond de un item del ListView
    return GestureDetector(
      onTap: () {
        //Marca que se selecciono un usuario
        paginaProvider.seleccion = true;
        //Pasa al provider el usuario seleccionado
        paginaProvider.modificar(model);
      },
      child: _datosUsuario(model),
    );
  }

  Container _datosUsuario(UsuarioModel model) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListTile(
        title: Text('Usuario:${model.usuario} '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Text('Direccion:${model.direccion} '),
            SizedBox(
              height: 3.0,
            ),
            Text('Email:${model.email} '),
          ],
        ),
        trailing: Column(
          children: <Widget>[
            SizedBox(
              height: 7.0,
            ),
            Text(
              'Edad',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(model.edad.toString())
          ],
        ),
      ),
    );
  }
}
