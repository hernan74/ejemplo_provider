import 'package:ejemplo_provider/pages/ejemplo_stream.dart';
import 'package:ejemplo_provider/provider/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:ejemplo_provider/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:ejemplo_provider/provider/pagina_provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(ThemeProvider.darkTheme), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaginaProvider()),
      ],
      child: MaterialApp(
        theme: themeProvider.getTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Provider',
        initialRoute: '/',
        routes: {'/': (_) => HomePage(), 'stream': (_) => StreamPage()},
      ),
    );
  }
}
