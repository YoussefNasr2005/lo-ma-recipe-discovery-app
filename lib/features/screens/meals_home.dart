import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/networking/services/random_meal_service.dart';
import 'package:small_food_app/core/networking/services/random_meals_service.dart';
import 'package:small_food_app/core/styles/app_colors.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:small_food_app/core/widgets/custom_futurebuilder_widget.dart';
import 'package:small_food_app/core/widgets/main_home_card_widget.dart';
import 'package:small_food_app/routing/app_routes.dart';

class MealsHome extends StatefulWidget {
  const MealsHome({super.key});

  @override
  State<MealsHome> createState() => _MealsHomeState();
}

class _MealsHomeState extends State<MealsHome> {
  MealModel? meal;
  int currentIndex = 0;
  late Future<MealsModel> _mealsFutureHome;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchedRandomMeal();
    _mealsFutureHome = RandomMealsService.searchByLetter(letter: 'a');
  }

  void fetchedRandomMeal() async {
    try {
      final fetchedMeal = await RandomMealService.getRandomMeal();
      if (!mounted) return;
      setState(() {
        meal = fetchedMeal;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: _appbarSection(),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                onSubmitted: (value) {
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRoutes.searchResult, extra: value);
                },

                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ابحث عن نوع وجبة, اكلة',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            SizedBox(height: 36.h),

            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Icon(Icons.fastfood, color: Colors.white),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'محتار تاكل اي انهاردة؟\nسيبها علينا واحنا نختارلك وجبة',
                        textDirection: TextDirection.rtl,
                        style: AppTextStyle.whiteSemiBold32.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          (meal == null || isLoading == true)
                              ? null
                              : GoRouter.of(context).pushNamed(
                                  AppRoutes.mealDetailsScreen,
                                  extra: meal,
                                );
                        },
                        child: Container(
                          height: 40.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              'فاجئني بوجبة',
                              style: AppTextStyle.blackMedium24.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              'تصفح الوجبات',
              style: AppTextStyle.whiteSemiBold32.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),

            SizedBox(height: 12.h),
            Expanded(
              child: CustomFuturebuilderWidget(
                mealsFutureBuilder: _mealsFutureHome,
                mealCard: (meal) => MainHomeCardWidget(meal: meal),
                isMainCard: true,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appbarSection() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        'لُقمة',
        style: AppTextStyle.blackMedium24.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: const CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
      leading: const Icon(
        Icons.notifications_none,
        color: AppColors.secondaryColor,
      ),
      centerTitle: true,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      iconSize: 30.sp,
      onTap: (v) {
        setState(() {
          currentIndex = v;
        });
        currentIndex == 1
            ? GoRouter.of(context).pushNamed(AppRoutes.favouritePage)
            : null;
      },

      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 1
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          label: 'المفضلة',
        ),
      ],
    );
  }
}
