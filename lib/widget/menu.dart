import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu.jpg'), fit: BoxFit.cover)),
          ),
          _crearItem(Icons.settings, 'Inicio', () {
            Navigator.pushReplacementNamed(context, '/');
          }),
          _crearItem(Icons.settings, 'Ajustes', () {
            Navigator.pushReplacementNamed(context, 'ajustes');
          })
        ],
      ),
    );
  }

  Widget _crearItem(IconData icon, String titulo, Function onTap) {
    return ListTile(
      title: Text(titulo),
      leading: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      onTap: onTap,
    );
  }
}
