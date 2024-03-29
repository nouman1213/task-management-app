import 'package:flutter/material.dart';

////
const Color fontGrey = Color.fromRGBO(107, 115, 119, 1);
const Color darkFontGrey = Color.fromRGBO(62, 68, 71, 1);
const Color golden = Color.fromRGBO(255, 168, 0, 1);
const Color lightGolden = Color(0xffFEEBD2);
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black,
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color.fromARGB(255, 60, 60, 105),
  onPrimaryContainer: Color(0xFF24282C),
  secondary: Color.fromARGB(255, 13, 22, 49),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCBE6FF),
  onSecondaryContainer: Color(0xFF001E30),
  tertiary: Color.fromARGB(255, 5, 117, 99),
  onTertiary: Color.fromARGB(234, 12, 12, 12),
  tertiaryContainer: Color.fromRGBO(200, 230, 201, 1),
  onTertiaryContainer: Color(0xFF00201B),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFB4AB),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFCFF),
  onBackground: Color(0xFF001E30),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF24282C),
  surfaceVariant: Color(0xFFF7F6F0),
  onSurfaceVariant: Color(0xFF46483C),
  outline: Color.fromARGB(255, 202, 202, 202),
  onInverseSurface: Color(0xFFE6F2FF),
  inverseSurface: Color.fromARGB(255, 34, 91, 176),
  inversePrimary: Color.fromARGB(255, 44, 119, 94),
  shadow: Color(0xFF000000),
  surfaceTint: Color.fromRGBO(104, 36, 96, 1),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.white,
  onPrimary: Colors.black,
  primaryContainer: Color.fromARGB(255, 153, 179, 255),
  onPrimaryContainer: Color.fromARGB(255, 111, 127, 174),
  secondary: Color(0xFF8ECDFF),
  onSecondary: Color.fromARGB(255, 128, 142, 155),
  secondaryContainer: Color.fromARGB(255, 62, 145, 186),
  onSecondaryContainer: Color(0xFFCBE6FF),
  tertiary: Color.fromARGB(255, 80, 158, 145),
  onTertiary: Color.fromARGB(234, 14, 14, 14),
  tertiaryContainer: Color.fromARGB(255, 45, 91, 83),
  onTertiaryContainer: Color(0xFFBCECE1),
  error: Color.fromARGB(255, 212, 97, 97),
  errorContainer: Color.fromARGB(255, 214, 102, 109),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001E30),
  onBackground: Color(0xFFCBE6FF),
  surface: Color(0xFF001E30),
  onSurface: Color(0xFFCBE6FF),
  surfaceVariant: Color(0xFF46483C),
  onSurfaceVariant: Color(0xFFC7C8B8),
  outline: Color(0xFFCBE6FF),
  onInverseSurface: Color(0xFF001E30),
  inverseSurface: Color.fromARGB(255, 87, 112, 135),
  inversePrimary: Color(0xFF526600),
  shadow: Color(0xFFCBE6FF),
  surfaceTint: Color.fromRGBO(91, 54, 86, 1),
);
