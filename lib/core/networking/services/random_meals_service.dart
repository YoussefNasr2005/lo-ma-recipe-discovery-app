import 'package:dio/dio.dart';
import 'package:small_food_app/core/networking/api_endpoints.dart';
import 'package:small_food_app/core/networking/dio_helper.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';

class RandomMealsService {
  static Future<MealsModel> searchByLetter({required String letter}) async {
    try {
      final Response response = await DioHelper.getDio(
        endPoint: ApiEndpoints.radnomMeals,
        query: {'f': letter},
      );
      final data = response.data['meals'];

      if (data == null || data.isEmpty) {
        throw Exception('No Meals Found!');
      } else {
        MealsModel randomMealsResult = MealsModel.fromJson(response.data);
        return randomMealsResult;
      }
    } catch (e) {
      rethrow;
    }
  }
}
