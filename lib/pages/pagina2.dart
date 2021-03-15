import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';
import 'package:ejemplo_provider/widget/crear_snack.dart';

class Pagina2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _formulario(context)));
  }

  _formulario(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    final UsuarioModel usuario = paginaProvider.nuevoUsuario;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          textCapitalization: TextCapitalization.words,
          controller: TextEditingController(text: usuario.usuario),
          decoration: InputDecoration(
            labelText: 'Nombre Usuario',
            border: OutlineInputBorder(),
          ),
          onChanged: (valor) {
            usuario.usuario = valor;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
            controller: TextEditingController(text: usuario.email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
            onChanged: (valor) {
              usuario.email = valor;
            }),
        SizedBox(
          height: 10.0,
        ),
        TextField(
          textCapitalization: TextCapitalization.words,
          controller: TextEditingController(text: usuario.direccion),
          decoration: InputDecoration(
              labelText: 'Direccion', border: OutlineInputBorder()),
          onChanged: (valor) {
            usuario.direccion = valor;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
            controller: TextEditingController(
                text: usuario.edad == null ? '' : usuario.edad.toString()),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Edad', border: OutlineInputBorder()),
            onChanged: (valor) {
              usuario.edad = valor == null ? '' : int.tryParse(valor);
            }),
        SizedBox(
          height: 10.0,
        ),
        _guardar(context, paginaProvider)
      ],
    );
  }

  ElevatedButton _guardar(BuildContext context, PaginaProvider paginaProvider) {
    return ElevatedButton(
        onPressed: () {
          if (_validar(context, paginaProvider.nuevoUsuario)) {
            paginaProvider.guardar();
            mostrarSnackBar(context: context, msj: 'Se guardo el registro');
          }
        },
        child: Text('Guardar'));
  }

  bool _validar(BuildContext context, UsuarioModel usuarioModel) {
    if (usuarioModel.usuario.isEmpty) {
      mostrarSnackBar(context: context, msj: 'Ingrese un Nombre');
      return false;
    }
    if (usuarioModel.email.isEmpty) {
      mostrarSnackBar(context: context, msj: 'Ingrese un Email');
      return false;
    }

    return true;
  }
}
