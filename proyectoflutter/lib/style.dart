import 'package:flutter/material.dart';
import 'package:proyectoflutter/design.dart';

class AppStyle {
       static InputDecoration inputDecoratio({String labelText = '', Color focusedBorderColor = const Color.fromARGB(255, 255, 145, 0)}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppDesign.subtitleTextStyle,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: 2.0,
        ),
      ),
    );
       }

      static ButtonStyle buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 145, 0),
            textStyle: TextStyle(color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );
            static ButtonStyle buttonStyle1(BuildContext context) => ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 255, 145, 0), 
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
        );
       }
       

