import 'package:flutter/material.dart';

class OurTheme {
  static const Color _lightGreen = Color.fromARGB(255, 213, 235, 220);
  //static final Color _lightGrey = const Color.fromARGB(255, 164, 164, 164);
  static const Color _darkGrey = Color.fromARGB(255, 119, 124, 135);

  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: _lightGreen,
    primaryColor: _lightGreen,
    secondaryHeaderColor: _darkGrey,
  );
}
