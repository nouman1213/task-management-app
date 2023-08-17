import 'package:flutter/material.dart';

import 'color_scheme.dart';

class Themes {
  //LightTheme
  static final light = ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
    primaryColorLight: Colors.blue,
  );

  //DarkTheme
  static final dark = ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    primaryColorDark: Colors.blue,
  );
}
