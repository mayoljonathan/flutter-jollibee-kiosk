import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';

// const kBackgroundColor = Color(0xFFCD1338);

const kScaffoldBackgroundColor = Color(0xFFFAF9FA);

const kYellow = Color(0xFFFFB617);
const kRed = Color(0xFFE5163E);

double kTitleTextSize = SizeConfig.blockSizeHorizontal * 5;
double kSubheadTextSize = SizeConfig.blockSizeHorizontal * 4;

final kFontFamily = 'GoogleSans';
final kPrimaryTextColor = Color(0xFF3A444D);
final kTextFieldBackgroundColor = Color(0xFFF2F4F6);
// final kScaffoldBackgroundColor = Color(0xFF00796B);
final kSecondaryTextColor = Color(0XFF707070); //95A0AA

// final kPrimaryColor = Color(0xFF043B01);
// final kPrimaryColor = Color(0xFF285E2C);
final kPrimaryColor = Colors.red;
// final kAccentColor = Color(0xFF8BC34A);

ThemeData kMaterialThemeData = ThemeData(
  primarySwatch: Colors.red,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
  ),
  // platform: TargetPlatform.iOS,
  brightness: Brightness.light,
  fontFamily: kFontFamily,
  primaryColor: kPrimaryColor,
  cursorColor: kPrimaryColor,
  textTheme: TextTheme(
    display1: TextStyle(
      color: kPrimaryColor,
      fontWeight: FontWeight.bold,
    ),
    body1: TextStyle(
      color: kPrimaryTextColor,
      fontSize: 15.0
    ),
    button: TextStyle(
      color: kPrimaryColor,
    ),
    subtitle: TextStyle(color: kSecondaryTextColor),
  ),
  iconTheme: IconThemeData(
    color: Colors.black54
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: kPrimaryColor,
    // height: 48.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0)
    ),
    
  )
);