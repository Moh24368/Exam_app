import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pinput/pinput.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      error: AppColors.error,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      titleTextStyle: AppTextStyle.appBarStyle,
    ),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      labelStyle: const TextStyle(color: AppColors.gray, fontSize: 12), 
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (s) => TextStyle(
          fontSize: 12,
          color: s.contains(WidgetState.error) ? AppColors.error : AppColors.gray,
        ),
      ),
      hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14), 
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
      enabledBorder: _outline(AppColors.gray),
      focusedBorder: _outline(AppColors.blue),
      errorBorder: _outline(AppColors.error),
      focusedErrorBorder: _outline(AppColors.error),
      border: _outline(AppColors.blackBase),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueBase,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.black30,
        disabledForegroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 48),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusRound)),
        textStyle: AppTextStyle.elevatedButtonText,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue,
        side: const BorderSide(color: AppColors.blue),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(fontSize: 16, decoration: TextDecoration.underline),
      ),
    ),


    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? AppColors.blue : Colors.transparent,
      ),
      checkColor: const WidgetStatePropertyAll(AppColors.white),
      side: const BorderSide(color: AppColors.blue, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),

    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.blue),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.lightBlue,
      indicatorColor: AppColors.blue10,
      elevation: 0,
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(
          color: s.contains(WidgetState.selected) ? AppColors.blue : AppColors.gray,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (s) => TextStyle(
          fontSize: 12,
          color: s.contains(WidgetState.selected) ? AppColors.blue : AppColors.gray,
        ),
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.blue,
      linearTrackColor: AppColors.black10,
      circularTrackColor: AppColors.black10,
    ),

    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static OutlineInputBorder _outline(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        borderSide: BorderSide(color: color),
      );

}

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
