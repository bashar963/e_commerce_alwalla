import 'package:flutter/material.dart';

const colorPrimary = Color(0xFFfafafa);
const colorPrimaryDark = Color(0xFFfafafa);
const colorAccent = Color(0xFFE80057);
const backgroundColor = Color(0xFFfafafa);

const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF000000);
const greenColor = Color(0xFF00C569);
const orangeColor = Color(0xFFFFC107);
const redColor = Color(0xFFFD314C);
const lightGrey = Color(0xFFDBDBDB);

const mainTextColor = Color(0xFF1E1E1E);
const subTextColor = Color(0xFFA2A2A2);

final appTheme = ThemeData(
    fontFamily: "SFPro",
    accentColor: colorAccent,
    primaryColor: colorPrimary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorDark: colorPrimaryDark,
    brightness: Brightness.light,
    canvasColor: whiteColor,
    scaffoldBackgroundColor: backgroundColor);
final appThemeAr = ThemeData(
    fontFamily: "Cairo",
    accentColor: colorAccent,
    primaryColor: colorPrimary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColorDark: colorPrimaryDark,
    brightness: Brightness.light,
    canvasColor: whiteColor,
    scaffoldBackgroundColor: backgroundColor);
const mainTextStyle =
    TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: mainTextColor);
const subTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: subTextColor);
