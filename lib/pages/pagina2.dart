import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';
import 'package:ejemplo_provider/widget/crear_snack.dart';

class Pagina2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              paginaProvider.paginaActual = 0;
            },
          ),
          title: Text('Provider'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: paginaProvider.seleccion
                    ? () {
                        paginaProvider.eliminar(paginaProvider.nuevoUsuario);
                        paginaProvider.paginaActual = 0;
                        mostrarSnackBar(
                            context: context, msj: 'Usuario eliminado');
                      }
                    : null)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
            child: Center(child: _formulario(context)),
          ),
        ));
  }

  _formulario(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    final UsuarioModel usuario = paginaProvider.nuevoUsuario;
    return Card(
      elevation: 5.0,
      shape:
          (RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _crearIcono(),
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
        ),
      ),
    );
  }

  Widget _crearIcono() {
    return Icon(
      Icons.account_circle_rounded,
      color: Colors.purple,
      size: 150.0,
    );
  }

  ElevatedButton _guardar(BuildContext context, PaginaProvider paginaProvider) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_validar(context, paginaProvider.nuevoUsuario)) {
          if (!paginaProvider.seleccion&& await paginaProvider
              .verificarEmail(paginaProvider.nuevoUsuario.email)) {
            mostrarSnackBar(context: context, msj: 'El email debe ser unico');
            return;
          }
          paginaProvider.guardar();
          mostrarSnackBar(context: context, msj: 'Se guardo el registro');
          paginaProvider.paginaActual = 0;
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Icon(Icons.save), Text('Guardar')],
      ),
    );
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
