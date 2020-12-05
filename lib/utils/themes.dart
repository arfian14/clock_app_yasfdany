import 'package:ClockApp/utils/responsive.dart';
import 'package:flutter/material.dart';

class Themes {
  BuildContext context;
  static Color black = Color(0xff2A2A2A);
  static Color primary = Color(0xff39C6E4);
  static Color lightPrimary = Color(0xff31E0E0);
  static Color secondary = Color(0xffED6A5A);
  static Color primaryDisableButton = Color(0xffF2C9D8);
  static Color red = Color(0xffF71735);
  static Color yellow = Color(0xffFFD228);
  static Color grey = Color(0xffF0F0F0);
  static Color green = Color(0xff03CEA4);
  static Color greyBg = Color(0xffF6F6F6);
  static Color stroke = Color(0xffDDDDDD);
  static Color white = Color(0xffffffff);
  static Color transparent = Color(0x00ffffff);

  TextStyle whiteBold32;
  TextStyle whiteBold28;
  TextStyle whiteBold26;
  TextStyle whiteBold22;
  TextStyle whiteOpacity14;
  TextStyle whiteOpacity12;
  TextStyle white16;
  TextStyle white14;
  TextStyle white12;
  TextStyle white10;
  TextStyle whiteBold16;
  TextStyle whiteBold14;
  TextStyle whiteBold12;
  TextStyle blackBold20;
  TextStyle black16;
  TextStyle blackOpacity12;
  TextStyle black70Opacity12;
  TextStyle blackBold16;
  TextStyle blackBold18;
  TextStyle secondaryBold18;
  TextStyle secondaryBold14;
  TextStyle blackBold12;
  TextStyle blackBold14;
  TextStyle black12;
  TextStyle black14;
  TextStyle blackOpacity14;
  TextStyle appbarTitle;
  TextStyle primaryBold22;
  TextStyle primaryBold18;
  TextStyle primaryBold14;
  TextStyle primaryBold12;

  TextStyle textStyle(double size, Color color, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(size),
      color: color,
      fontWeight: fontWeight,
    );
  }

  Themes(this.context) {
    primaryBold12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Themes.primary,
      fontWeight: FontWeight.bold,
    );

    primaryBold14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Themes.primary,
      fontWeight: FontWeight.bold,
    );

    primaryBold22 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(22),
      color: Themes.primary,
      fontWeight: FontWeight.bold,
    );

    primaryBold18 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(18),
      color: Themes.primary,
      fontWeight: FontWeight.bold,
    );

    appbarTitle = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(26),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    blackBold20 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(20),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    black16 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(16),
      color: Themes.black.withOpacity(0.7),
    );

    secondaryBold14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Themes.secondary,
      fontWeight: FontWeight.bold,
    );

    secondaryBold18 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(18),
      color: Themes.secondary,
      fontWeight: FontWeight.bold,
    );

    blackBold18 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(18),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    black70Opacity12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    blackOpacity12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Themes.black.withOpacity(0.6),
    );

    blackBold16 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(16),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    blackOpacity14 = TextStyle(
      fontSize: Responsive(context).f(14),
      color: Themes.black.withOpacity(0.6),
    );

    blackBold12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    blackBold14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Themes.black.withOpacity(0.7),
      fontWeight: FontWeight.bold,
    );

    black12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Themes.black.withOpacity(0.7),
    );

    white16 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(16),
      color: Colors.white,
    );

    white14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Colors.white,
    );

    white12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Colors.white,
    );

    white10 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(10),
      color: Colors.white,
    );

    black14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Themes.black.withOpacity(0.7),
    );

    whiteBold16 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(16),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteOpacity14 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(14),
      color: Colors.white.withOpacity(0.7),
    );

    whiteOpacity12 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(12),
      color: Colors.white.withOpacity(0.7),
    );

    whiteBold32 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(32),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold28 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(28),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold26 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(26),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    whiteBold22 = TextStyle(
      fontFamily: "NReguler",
      fontSize: Responsive(context).f(22),
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}
