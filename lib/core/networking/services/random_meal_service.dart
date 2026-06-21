import 'package:dio/dio.dart';
import 'package:small_food_app/core/networking/api_endpoints.dart';
import 'package:small_food_app/core/networking/dio_helper.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';

class RandomMealService {
  static Future<MealModel> getRandomMeal() async {
    try {
      final Response response = await DioHelper.getDio(
        endPoint: ApiEndpoints.radnomMeal,
      );
      final data = response.data['meals'];
      if (data == null || data.isEmpty) {
        throw Exception('No Meals Found!');
      } else {
        MealModel modelRandomMeal = MealModel.fromJson(data[0]);
        return modelRandomMeal;
      }
    } catch (e) {
      rethrow;
    }
  }
}
