import 'package:ejemplo_provider/utils/hex_color_util.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  static final String _colorPrimarioLight = '#3700B3';
  static final String _colorSurfaceLight = '#FFFFFF';
  static final String _colorLetraLight = '#121212';

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      //colorScheme: ColorScheme(primary: primary, primaryVariant: primaryVariant, secondary: secondary, secondaryVariant: secondaryVariant, surface: surface, background: background, error: error, onPrimary: onPrimary, onSecondary: onSecondary, onSurface: onSurface, onBackground: onBackground, onError: onError, brightness: brightness),
      primaryColor: HexColor.fromHex(_colorPrimarioLight),
      primaryColorDark: HexColor.fromHex(_colorPrimarioLight),
      secondaryHeaderColor: HexColor.fromHex(_colorPrimarioLight),
      accentColor: HexColor.fromHex(_colorLetraLight),
      cardColor: HexColor.fromHex(_colorSurfaceLight),
      selectedRowColor: HexColor.fromHex(_colorSurfaceLight),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              HexColor.fromHex(_colorPrimarioLight)),
        ),
      ));

  static final String _colorPrimarioDark = '#6200EE';
  static final String _colorSurfaceDark = '#121212';
  static final String _colorLetraDark = '#ffffff';
  static final String _colorErrorDark = '#CF6679';

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColorDark: HexColor.fromHex(_colorPrimarioDark),
      secondaryHeaderColor: HexColor.fromHex(_colorPrimarioDark),
      errorColor: HexColor.fromHex(_colorErrorDark),
      accentColor: HexColor.fromHex(_colorLetraDark),
      cardColor: HexColor.fromHex(_colorSurfaceDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              HexColor.fromHex(_colorPrimarioDark)),
        ),
      )
      /* dark theme settings */
      );

  ThemeData _themeData = lightTheme;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
