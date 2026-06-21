import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:small_food_app/routing/app_routes.dart';

class MainHomeCardWidget extends StatelessWidget {
  final MealModel meal;
  const MainHomeCardWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () => GoRouter.of(
            context,
          ).pushNamed(AppRoutes.mealDetailsScreen, extra: meal),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8.r),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  imageUrl: meal.strMealThumb ?? '',
                  height: 100.h,
                  width: 150.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  meal.strMeal ?? '',
                  maxLines: 2,
                  style: AppTextStyle.blackMedium24.copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '${meal.strArea ?? ''} | ${meal.strCategory ?? ''}',
                ),
              ),
            ],
          ),
        ),
      ),

      // CardDetails(),
    );
  }
}
