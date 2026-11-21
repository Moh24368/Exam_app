import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding:  EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.0.h),
      labelStyle:  TextStyle(color: AppColors.gray, fontSize: 12.sp), 
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (s) => TextStyle(
          fontSize: 16.sp,
          color: s.contains(WidgetState.error) ? AppColors.error : AppColors.gray,
        ),
      ),
      
      hintStyle:  TextStyle(color: AppColors.gray, fontSize: 14.sp), 
      errorStyle:  TextStyle(color: AppColors.error, fontSize: 12.sp),
      enabledBorder: _outline(AppColors.gray),
      focusedBorder: _outline(AppColors.blue),
      errorBorder: _outline(AppColors.error),
      focusedErrorBorder: _outline(AppColors.error),
      border: _outline(AppColors.gray),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.gray,
        disabledForegroundColor: AppColors.white,
        minimumSize:  Size(double.infinity, 48.0.h),
        padding: EdgeInsets.symmetric(vertical: 14.0.h),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        textStyle:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500), 
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue,
        side: const BorderSide(color: AppColors.blue),
        minimumSize:  Size(double.infinity, 48.0.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        textStyle:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle:  TextStyle(fontSize: 16.sp, decoration: TextDecoration.underline),
      ),
    ),


    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? AppColors.blue : Colors.transparent,
      ),
      checkColor: const WidgetStatePropertyAll(AppColors.white),
      side:  BorderSide(color: AppColors.blue, width: 1.5.w),
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
          fontSize: 12.sp,
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
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color),
      );
}