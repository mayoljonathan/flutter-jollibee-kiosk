import 'package:flutter/material.dart';

const kCoreBackgroundColor = Color(0xFFCD1338);

const kCoreYellow = Color(0xFFFFB617);
const kCoreRed = Color(0xFFE5163E);

final kCoreFontFamily = 'GoogleSans';
final kCorePrimaryTextColor = Color(0xFF3A444D);
final kCoreTextFieldBackgroundColor = Color(0xFFF2F4F6);
// final kCoreScaffoldBackgroundColor = Color(0xFF00796B);
final kCoreSecondaryTextColor = Color(0XFF707070); //95A0AA

// final kCorePrimaryColor = Color(0xFF043B01);
// final kCorePrimaryColor = Color(0xFF285E2C);
final kCorePrimaryColor = Colors.red;
// final kCoreAccentColor = Color(0xFF8BC34A);

ThemeData kMaterialThemeData = ThemeData(
  primarySwatch: Colors.red,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kCorePrimaryColor,
  ),
  // platform: TargetPlatform.iOS,
  brightness: Brightness.light,
  fontFamily: kCoreFontFamily,
  primaryColor: kCorePrimaryColor,
  cursorColor: kCorePrimaryColor,
  textTheme: TextTheme(
    display1: TextStyle(
      color: kCorePrimaryColor,
      fontWeight: FontWeight.bold,
    ),
    body1: TextStyle(
      color: kCorePrimaryTextColor,
      fontSize: 15.0
    ),
    button: TextStyle(
      color: kCorePrimaryColor,
    ),
    subtitle: TextStyle(color: kCoreSecondaryTextColor),
  ),
  iconTheme: IconThemeData(
    color: Colors.black54
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: kCorePrimaryColor,
    // height: 48.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0)
    ),
    
  )
);