import 'package:flutter/material.dart';
import 'package:medaid/components/dory_colors.dart';

class DoryThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: DoryColors.primaryMaterialColor,
        fontFamily: "GmarketSansTTF",
        scaffoldBackgroundColor: Colors.white,
        textTheme: _textTheme,
        splashColor: Colors.white,
        brightness: Brightness.light,
      );
  static ThemeData get darkTheme => ThemeData(
    primarySwatch: DoryColors.primaryMaterialColor,
    fontFamily: "GmarketSansTTF",
    textTheme: _textTheme,
    splashColor: Colors.white,
    brightness: Brightness.dark,
  );

  static const TextTheme _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: DoryColors.primaryColor,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: DoryColors.primaryColor,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: DoryColors.primaryColor,
    ),
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: DoryColors.primaryColor,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: DoryColors.primaryColor,
    ),
    button: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: DoryColors.primaryColor,
    ),
  );
}
