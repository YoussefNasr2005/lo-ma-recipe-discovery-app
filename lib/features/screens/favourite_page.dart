import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/styles/app_colors.dart';
import 'package:small_food_app/core/styles/app_text_style.dart';
import 'package:small_food_app/core/widgets/meal_card_widget.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarSection(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),

        child: ValueListenableBuilder(
          valueListenable: Hive.box<MealModel>('favorites').listenable(),
          builder: (BuildContext context, box, Widget? child) {
            final favorites = box.values.toList();
            return favorites.isEmpty
                ?  Center(
                    child: Text(
                      '.لا توجد وجبات مفضلة لديك حتى الان',
                      style: AppTextStyle.blackRegular14C12,
                    ),
                  )
                : ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return MealCardWidget(meal: favorites[index]);
                    },
                  );
          },
        ),
      ),
    );
  }

  AppBar _appbarSection() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        'المفضلة',
        style: AppTextStyle.blackMedium24.copyWith(fontWeight: FontWeight.bold),
      ),

      centerTitle: true,
    );
  }
}
