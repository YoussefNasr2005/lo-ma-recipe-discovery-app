import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:small_food_app/core/database/app_prefernces.dart';
import 'package:small_food_app/core/networking/dio_helper.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/routing/router_generation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.initDio();

  await Hive.initFlutter();
  Hive.registerAdapter(MealModelAdapter());
  await Hive.openBox<MealModel>('favorites');

  RouterGeneration.isFirstLogin = await AppPrefernces.getIsFirstLogin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouterGeneration.goRouter,
      ),
    );
  }
}
