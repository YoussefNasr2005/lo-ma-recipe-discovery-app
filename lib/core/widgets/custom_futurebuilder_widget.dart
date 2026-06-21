import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';

class CustomFuturebuilderWidget extends StatelessWidget {
  final Future<MealsModel> mealsFutureBuilder;
  final Widget Function(MealModel meal) mealCard;
  final bool isMainCard;

  const CustomFuturebuilderWidget({
    super.key,
    required this.mealCard,
    required this.mealsFutureBuilder,
    required this.isMainCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: mealsFutureBuilder,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final meals = snapshot.data!.meals;
            if (meals.isEmpty) {
              return const Center(
                child: Text('لا يوجد اي وجبات من هذا النوع.'),
              );
            } else {
              return isMainCard
                  ? GridView.builder(
                      itemBuilder: (context, index) {
                        return mealCard(meals[index]);
                      },
                      itemCount: meals.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30.h,
                        mainAxisSpacing: 5.w,
                        childAspectRatio: .8,
                      ),
                    )
                  : ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        return mealCard(meals[index]);
                      },
                    );
            }
          }
          return const Center(child: Text('!لقد حدث شيء ما خطاء'));
        },
      ),
    );
  }
}
