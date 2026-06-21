import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_food_app/core/styles/app_colors.dart';

class AppTextStyle {
  static TextStyle get whiteSemiBold32 => TextStyle(
    color: AppColors.whiteColor,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get whiteRegular14 => TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get blackMedium24 => TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get blackRegular14C12 => TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
