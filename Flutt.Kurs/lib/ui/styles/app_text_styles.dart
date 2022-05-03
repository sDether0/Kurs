import 'package:flutter/material.dart';
import 'package:kurs/resources/app_colors.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 20,
      fontFamily: "Arvo",
      fontWeight: FontWeight.w500);

  static const TextStyle h2 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 18,
      fontFamily: "Arvo",
      fontWeight: FontWeight.w100);

  static const TextStyle h3 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 15,
      fontFamily: "Arvo",
      fontWeight: FontWeight.normal);

  static const TextStyle h4 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 11,
      fontFamily: "Arvo",
      fontWeight: FontWeight.normal);
}

extension AppTextExtension on TextStyle {

  TextStyle primary() => copyWith(color: AppColors.primaryTextColor);

  TextStyle white() => copyWith(color: Colors.white);

  TextStyle black() => copyWith(color: Colors.black);

  TextStyle action() => copyWith(color: AppColors.actionsMenuColor);

  TextStyle bold900() => copyWith(fontWeight: FontWeight.w900);

  TextStyle bold500() => copyWith(fontWeight: FontWeight.w500);

  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);

  //TextStyle font() => copyWith(fontFamily: 'Arial');

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle opacity(double op) => copyWith(color: color!.withOpacity(op));

  TextStyle underline() => copyWith(decoration: TextDecoration.underline);
}