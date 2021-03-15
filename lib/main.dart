import 'package:flutter/material.dart';

import 'package:ejemplo_provider/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaginaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider',
        home: HomePage(),
      ),
    );
  }
}
