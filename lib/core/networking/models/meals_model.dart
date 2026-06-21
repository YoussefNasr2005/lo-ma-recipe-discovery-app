import 'package:hive/hive.dart';
part 'meals_model.g.dart';

class MealsModel {
  final List<MealModel> meals;

  MealsModel({required this.meals});

  factory MealsModel.fromJson(Map<String, dynamic> json) {
    final mealsJson = json['meals'] as List?;

    return MealsModel(
      meals: mealsJson == null
          ? []
          : List<MealModel>.from(
              mealsJson.map((meal) => MealModel.fromJson(meal)),
            ),
    );
  }
}

@HiveType(typeId: 0)
class MealModel {
  @HiveField(0)
  String? idMeal;
  @HiveField(1)
  String? strMeal;
  @HiveField(2)
  String? strMealThumb;
  @HiveField(3)
  String? strInstructions;
  @HiveField(4)
  String? strYoutube;
  @HiveField(5)
  String? strCategory;
  @HiveField(6)
  String? strArea;
  @HiveField(7)
  String? strCountry;

  @HiveField(8)
  List<String> strIngredient;
  @HiveField(9)
  List<String> strMeasure;

  MealModel({
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
    this.strInstructions,
    this.strYoutube,
    this.strCategory,
    this.strArea,
    this.strCountry,
    required this.strIngredient,
    required this.strMeasure,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (var i = 1; i < 21; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient == null || ingredient.toString().trim().isEmpty) {
        continue;
      }

      ingredients.add(ingredient.toString().trim());
      measures.add(measure != null ? measure.toString().trim() : '');
    }

    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strCountry: json['strCountry'],
      strIngredient: ingredients,
      strMeasure: measures,
    );
  }
}
