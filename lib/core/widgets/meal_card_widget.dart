import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:small_food_app/routing/app_routes.dart';

class MealCardWidget extends StatelessWidget {
  final MealModel meal;

  const MealCardWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(
            context,
          ).pushNamed(AppRoutes.mealDetailsScreen, extra: meal);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      meal.strMeal ?? '',
                      maxLines: 1,
                      style: AppTextStyle.blackMedium24,
                    ),
                  ),

                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${meal.strCountry} |  ${meal.strCategory}',
                      maxLines: 2,
                      style: AppTextStyle.blackRegular14C12.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),

              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb ?? '',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),

                height: 80.h,
                width: 112.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
