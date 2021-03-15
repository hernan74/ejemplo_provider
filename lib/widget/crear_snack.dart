import 'package:flutter/material.dart';

  void mostrarSnackBar({@required BuildContext context, @required String msj}) {
    final snak = SnackBar(
      content: Text(
        msj,
        style: TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      duration: Duration(milliseconds: 1500),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snak);
  }

