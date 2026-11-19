import 'package:exam/core/constants/app_icons.dart';
import 'package:exam/core/constants/app_strings.dart';
import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.fieldPaddingH),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                SizedBox(height: AppSizes.spaceXl),
                Text(
                  AppStrings.forgotPasswordTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.forgotPasswordTitle,
                ),
                SizedBox(height: AppSizes.spaceMd),
                Text(
                  AppStrings.forgotPasswordSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.forgotPasswordSubtile,
                ),
                SizedBox(height: AppSizes.spaceLg),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: AppStrings.emailLabel,
                    hintText: AppStrings.emailHint,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      borderSide: BorderSide(color: AppColors.blackBase),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      borderSide: BorderSide(color: AppColors.blackBase),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.spaceXxl,),

                SizedBox(height: AppSizes.spaceXxl,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueBase,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
                      ),
                    ),
                    child: Text(AppStrings.continueLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(AppIcons.backArrow, width: AppSizes.iconSm, height: AppSizes.iconSm),
        ),
        title: Text(
          AppStrings.passwordAppBarTitle,
          style: AppTextStyle.passwordText,
        ),
      ),
    );
  }
}
