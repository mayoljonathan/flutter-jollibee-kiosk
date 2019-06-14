import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';

// TODO: Doesn't shown when app is profile/release
final double kTitleTextSize = SizeConfig.blockSizeHorizontal * 5;
final double kSubheadTextSize = SizeConfig.blockSizeHorizontal * 4;
final double kActionButtonTextSize = SizeConfig.blockSizeHorizontal * 3;
final double kBodyTextSize = SizeConfig.blockSizeHorizontal * 2.5;
final double kCaptionTextSize = SizeConfig.blockSizeHorizontal * 2;
final double kOverlineTextSize = SizeConfig.blockSizeHorizontal * 1.8;

// const kBackgroundColor = Color(0xFFCD1338);

const kCanvasColor = Color(0xFFFAF9FA);

const kYellow = Color(0xFFFFB617);
const kRed = Color(0xFFE5163E);
const kGreen = Colors.green;
const kGrey = Colors.grey;


final kFontFamily = 'GoogleSans';
final kPrimaryTextColor = Color(0xFF3A444D);
final kTextFieldBackgroundColor = Color(0xFFF2F4F6);
// final kScaffoldBackgroundColor = Color(0xFF00796B);
final kSecondaryTextColor = Color(0XFF707070); //95A0AA

ThemeData kMaterialThemeData = ThemeData(
  primarySwatch: Colors.red,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kRed,
  ),
  // platform: TargetPlatform.iOS,
  brightness: Brightness.light,
  fontFamily: kFontFamily,
  primaryColor: kRed,
  cursorColor: kRed,
  canvasColor: kCanvasColor,
  textTheme: TextTheme(
    display1: TextStyle(
      color: kRed,
      fontWeight: FontWeight.bold,
    ),
    body1: TextStyle(
      color: kPrimaryTextColor,
      fontSize: 15.0
    ),
    button: TextStyle(
      color: kRed,
    ),
    subtitle: TextStyle(color: kSecondaryTextColor),
  ),
  iconTheme: IconThemeData(
    color: Colors.black54
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: kRed,
    // height: 48.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0)
    ),
    
  )
);