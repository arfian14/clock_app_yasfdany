// import 'package:connectivity/connectivity.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
// import 'package:flutter_money_formatter/flutter_money_formatter.dart';
// import 'package:timeago/timeago.dart' as timeago;

class Tools {
  static showToast({String text, Toast duration = Toast.LENGTH_SHORT}) {
    FlutterFlexibleToast.showToast(
      message: text,
      toastLength: duration,
      toastGravity: ToastGravity.BOTTOM,
      radius: 24,
      elevation: 10,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      timeInSeconds: 1,
    );
  }

  static Future<File> copyFileFromAssets(String path, String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final file = File(path);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static void navigateReplace(BuildContext context, var screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }

  static void navigatePush(BuildContext context, var screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }

  static Future<dynamic> navigatePushAsync(
      BuildContext context, var screen) async {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
    );
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static Future writeFile(String text, String path) async {
    final File file = File(path);
    await file.writeAsString(text, flush: true);
  }

  static Future<String> readFile(String path) async {
    String text;
    try {
      final File file = File(path);
      text = await file.readAsString();
    } catch (e) {
      return null;
    }
    return text;
  }

  static void navigateRefresh(BuildContext context, var screen, String route) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      ModalRoute.withName(route),
    );
  }

  static getApplicationDocumentsDirectory() {}
}
