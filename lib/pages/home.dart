import 'package:ejemplo_provider/provider/pagina_provider.dart';
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
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: paginaProvider.pageController,
        children: [
          Pagina1(),
          Pagina2(),
        ],
      ),
      bottomNavigationBar: _bottonNavigator(context),
    );
  }

  Widget _bottonNavigator(BuildContext context) {
    final provider = Provider.of<PaginaProvider>(context);
    return BottomNavigationBar(
      currentIndex: provider.pagina,
      onTap: (i) {
        //Cambia la pagina
        provider.paginaActual = i;
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(label: 'Lista Usuario', icon: Icon(Icons.list)),
        BottomNavigationBarItem(
            label: 'Usuario', icon: Icon(Icons.people_outline_sharp))
      ],
    );
  }
}
