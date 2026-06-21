import 'package:dio/dio.dart';
import 'package:small_food_app/core/networking/api_endpoints.dart';
import 'package:small_food_app/core/networking/dio_helper.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';

class SearchService {
  static Future<MealsModel> searchByName({required String name}) async {
    try {
      final Response response = await DioHelper.getDio(
        endPoint: ApiEndpoints.searchByName,
        query: {'s': name},
      );
      final data = response.data['meals'];

      if (data == null || data.isEmpty) {
        throw ('No Meals Found!');
      } else {
        MealsModel searchModelResult = MealsModel.fromJson(response.data);
        return searchModelResult;
      }
    } catch (e) {
      rethrow;
    }
  }
}
