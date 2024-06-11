import 'package:flutter/material.dart';

class AppDesign {
  static const Color primaryColor = Color.fromARGB(255, 17, 0, 255);
  static const Color accentColor = Color.fromARGB(255, 255, 255, 255);
  static const Color textColor = Color.fromARGB(255, 0, 0, 0);
    static const Color textColor1 = Color.fromARGB(255, 255, 255, 255);


  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: textColor,
  );

  static const TextStyle boton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: textColor1,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: textColor1,
  );

}
