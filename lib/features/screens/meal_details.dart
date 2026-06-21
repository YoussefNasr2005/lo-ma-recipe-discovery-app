import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/networking/services/favourites_services.dart';
import 'package:small_food_app/core/styles/app_colors.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsScreen extends StatefulWidget {
  final MealModel meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = FavouritesServices.isFavorite(widget.meal.idMeal as String);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mealsLength = widget.meal.strIngredient.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.45,
            child: CachedNetworkImage(
              imageUrl: widget.meal.strMealThumb ?? '',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.4),

                  Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 32.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.meal.strMeal ?? '',
                          style: AppTextStyle.blackMedium24.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              color: AppColors.primaryColor,
                              onPressed: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                                isSelected
                                    ? FavouritesServices.addToFavourites(
                                        widget.meal,
                                      )
                                    : FavouritesServices.removeFromFavorites(
                                        widget.meal.idMeal as String,
                                      );
                              },
                              icon: isSelected
                                  ? Icon(Icons.favorite, size: 35.sp)
                                  : Icon(Icons.favorite_border, size: 35.sp),
                            ),
                            Text(
                              '${widget.meal.strCategory ?? ''} | ${widget.meal.strArea ?? ''}',
                              style: AppTextStyle.blackMedium24.copyWith(
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),

                        Divider(
                          height: screenSize.width * .09,
                          thickness: 1.h,
                          color: Colors.black,
                        ),

                        Text(
                          ':طريقة التحضير',
                          style: AppTextStyle.blackMedium24.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          widget.meal.strInstructions ?? '',
                          style: AppTextStyle.blackRegular14C12.copyWith(),
                        ),
                        Divider(
                          height: screenSize.width * .09,
                          thickness: 1.h,
                          color: Colors.black,
                        ),

                        Text(
                          ':المكونات والمقادير',
                          style: AppTextStyle.blackMedium24.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,

                          spacing: 20.w,
                          runSpacing: 10.h,
                          children: [
                            ...List.generate(
                              mealsLength,
                              (index) => Text(
                                '${widget.meal.strIngredient[index]} ${widget.meal.strMeasure[index]}',
                                style: AppTextStyle.blackRegular14C12,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: screenSize.width * .09,
                          thickness: 1.h,
                          color: Colors.black,
                        ),

                        SizedBox(height: 12.h),

                        Text(
                          ':رابط اليوتيوب',
                          style: AppTextStyle.blackMedium24.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        (widget.meal.strYoutube != null &&
                                widget.meal.strYoutube!.isNotEmpty)
                            ? ElevatedButton.icon(
                                onPressed: () async {
                                  final Uri url = Uri.parse(
                                    widget.meal.strYoutube!,
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'مشاهدة طريقة التحضير على يوتيوب',
                                  style: AppTextStyle.blackRegular14C12
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[700],
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 16.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                              )
                            : Text(
                                'رابط اليوتيوب غير متوفر لهذه الوجبة',
                                style: AppTextStyle.blackRegular14C12,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 48.h,
            right: 24.w,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
