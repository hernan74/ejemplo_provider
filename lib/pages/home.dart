import 'package:ejemplo_provider/model/usuario_model.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';
import 'package:ejemplo_provider/widget/crear_snack.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_provider/pages/pagina1.dart';
import 'package:ejemplo_provider/pages/pagina2.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    paginaProvider.cargarUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                paginaProvider.borrarTodos();
              })
        ],
      ),
      body: Container(
        child: _cambiarPagina(context),
      ),
      floatingActionButton: _floatActionBotton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _bottonNavigator(context),
    );
  }

  Widget _cambiarPagina(BuildContext context) {
    final paginaProvider = Provider.of<PaginaProvider>(context);
    switch (paginaProvider.pagina) {
      case 0:
        return Pagina1();
        break;
      case 1:
        return Pagina2();
        break;
      default:
        return Pagina1();
        break;
    }
  }
}

_floatActionBotton(BuildContext context) {
  final provider = Provider.of<PaginaProvider>(context);
  return provider.pagina == 1
      ? Container()
      : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
                backgroundColor:
                    provider.seleccion ? Colors.blueAccent : Colors.black54,
                child: Icon(Icons.delete),
                onPressed: provider.seleccion
                    ? () {
                        provider.eliminar();
                        mostrarSnackBar(
                            context: context, msj: 'Usuario eliminado');
                      }
                    : null),
            SizedBox(
              height: 10.0,
            ),
            FloatingActionButton(
                backgroundColor:
                    provider.seleccion ? Colors.blueAccent : Colors.black54,
                child: Icon(Icons.edit),
                onPressed: provider.seleccion
                    ? () {
                        provider.pagina = 1;
                      }
                    : null),
          ],
        );
}

Widget _bottonNavigator(BuildContext context) {
  final provider = Provider.of<PaginaProvider>(context);
  return BottomNavigationBar(
    currentIndex: provider.pagina,
    onTap: (i) {
      //Cambia la pagina
      provider.pagina = i;
      //Limpia si se hizo una seleccion de usuario para que cree uno nuevo
      provider.seleccion = false;
      provider.modificar(new UsuarioModel());
    },
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          label: 'Pagina 1', icon: Icon(Icons.last_page_sharp)),
      BottomNavigationBarItem(label: 'Pagina 2', icon: Icon(Icons.first_page))
    ],
  );
}
