import 'package:flutter/material.dart';
import 'package:kurs/resources/app_colors.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w500);

  static const TextStyle h2 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w100);

  static const TextStyle h3 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 15,
      fontWeight: FontWeight.normal);

  static const TextStyle h4 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 12,
      fontWeight: FontWeight.normal);
}

extension AppTextExtension on TextStyle {

  Color? getColor() { print(copyWith(color:color!.withOpacity(0.7))); return color;}

  TextStyle primary() => copyWith(color: AppColors.primaryTextColor);

  TextStyle white() => copyWith(color: Colors.white);

  TextStyle black() => copyWith(color: Colors.black);

  //TextStyle grey() => copyWith(color: AppColors.darkGrey);

  TextStyle bold900() => copyWith(fontWeight: FontWeight.w900);

  TextStyle bold500() => copyWith(fontWeight: FontWeight.w500);

  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);

  //TextStyle font() => copyWith(fontFamily: 'Arial');

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle opacity(double op) => copyWith(color: color!.withOpacity(op));

  TextStyle underline() => copyWith(decoration: TextDecoration.underline);
}