import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:small_food_app/core/app_assets/app_assets.dart';
import 'package:small_food_app/core/database/app_prefernces.dart';
import 'package:small_food_app/core/styles/app_colors.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:small_food_app/routing/app_routes.dart';
import 'package:small_food_app/routing/router_generation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> titles = [
    'اكتشف وجبات جديدة',
    '"ابحث عن وجبتك المفضلة',
    'تصفح حسب التصنيف',
  ];

  final List<String> descriptions = [
    'دع التطبيق يقترح عليك وجبات شهية ومميزة كل يوم',
    'اعثر على أي وجبة بسهولة باستخدام اسمها',
    'استكشف مجموعة متنوعة من الوجبات حسب النوع والتصنيف',
  ];

  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.onBoardingImage, fit: BoxFit.cover),
          ),

          Positioned(
            bottom: 40.w,
            left: 32.w,
            right: 32.w,
            child: Container(
              height: 380.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .9),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 19.h),
                child: Column(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        carouselController: carouselSliderController,
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index.toDouble();
                            });
                          },
                          height: double.infinity,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                        ),
                        items: List.generate(titles.length, (index) {
                          return Builder(
                            builder: (BuildContext context) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  titles[index],
                                  style: AppTextStyle.whiteSemiBold32,
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 16.h),

                                Text(
                                  descriptions[index],
                                  style: AppTextStyle.blackMedium24
                                      .copyWith(fontSize: 20.sp)
                                      .copyWith(color: AppColors.whiteColor),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 24.h),

                                DotsIndicator(
                                  onTap: (index) {
                                    carouselSliderController.animateToPage(
                                      index,
                                    );
                                    setState(() {});
                                  },
                                  dotsCount: titles.length,
                                  position: index.toDouble(),
                                  decorator: DotsDecorator(
                                    size: const Size(26, 6),
                                    activeSize: const Size(26, 6),
                                    activeColor: AppColors.whiteColor,
                                    color: const Color(0xffC2C2C2),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24.h),

                                currentIndex == 2
                                    ? Container(
                                        height: 56.w,
                                        width: 56.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(
                                            84.sp,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            await AppPrefernces.setIsFirstLogin(
                                              false,
                                            );
                                            RouterGeneration.isFirstLogin =
                                                false;
                                            if (!context.mounted) return;
                                            GoRouter.of(
                                              context,
                                            ).pushReplacementNamed(
                                              AppRoutes.mealsHome,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                            size: 28.sp,
                                          ),
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              carouselSliderController
                                                  .animateToPage(2);
                                            },
                                            child: Text(
                                              'Skip',
                                              style:
                                                  AppTextStyle.whiteRegular14,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (currentIndex <= 1) {
                                                currentIndex++;
                                                carouselSliderController
                                                    .animateToPage(
                                                      currentIndex.toInt(),
                                                    );
                                              }
                                            },
                                            child: Text(
                                              'Next',
                                              style:
                                                  AppTextStyle.whiteRegular14,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
