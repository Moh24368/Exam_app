import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pinput/pinput.dart';

abstract class AppPinTheme {
  static PinTheme defaultTheme(double width) => PinTheme(
        width: width,
        height: AppSizes.otpBoxHeight,
        textStyle: AppTextStyle.otpDigitStyle,
        decoration: BoxDecoration(
          color: AppColors.blue10,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
      );

  static PinTheme focusedTheme(double width) => defaultTheme(width)
      .copyBorderWith(border: Border.all(color: AppColors.blue));

  static PinTheme errorTheme(double width) => defaultTheme(width)
      .copyBorderWith(border: Border.all(color: AppColors.error));
}