import 'package:exam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const passwordText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.blackBase,
  );
  static const forgotPasswordTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.blackBase
  );
  static const forgotPasswordSubtile = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.gray
  );
}
