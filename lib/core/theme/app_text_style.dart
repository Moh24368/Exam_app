import 'package:exam/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

abstract class AppTextStyle {
  static const TextStyle appBarStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.blackBase,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.blackBase,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.gray,
  );

  static const TextStyle elevatedButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const TextStyle otpDigitStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.blackBase,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: AppColors.blackBase,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    color: AppColors.error,
  );
}