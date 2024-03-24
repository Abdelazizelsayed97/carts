import 'dart:ui';

import 'package:flutter/material.dart';

class AppTextStyles{
 static TextStyle bold({ double? fontSize, Color? color,String? fontFamily}){
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily??'somar san',
      fontSize: fontSize ??14,
        color: color ?? Colors.black
    );
  }
 static TextStyle normal({ double? fontSize, Color? color,String? fontFamily}){
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily??'somar san',
      fontSize: fontSize ??14,
        color: color ?? Colors.black
    );
  }
 static TextStyle semiBold({ double? fontSize, Color? color,String? fontFamily}){
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily??'somar san',
      fontSize: fontSize ??14,
        color: color ?? Colors.black
    );
  }
 static TextStyle thin({ double? fontSize, Color? color,String? fontFamily}){
    return TextStyle(
      fontWeight: FontWeight.w200,
      fontFamily: fontFamily??'somar san',
      fontSize: fontSize ??14,
        color: color ?? Colors.black
    );
  }
}