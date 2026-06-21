import 'package:hive_flutter/adapters.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';

class FavouritesServices {
  static final Box<MealModel> _box = Hive.box<MealModel>('favorites');

  static Future<void> addToFavourites(MealModel meal) async {
    await _box.put(meal.idMeal, meal);
  }

  static Future<void> removeFromFavorites(String mealId) async {
    await _box.delete(mealId);
  }

  static Future<void> removeAllFavorites() async {
    await _box.clear();
  }

  static List<MealModel> getAllFavorites() {
    return _box.values.toList();
  }

  static bool isFavorite(String mealId) {
    bool isFavorite = _box.containsKey(mealId);
    return isFavorite;
  }
}
