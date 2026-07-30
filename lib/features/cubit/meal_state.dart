import 'package:small_food_app/core/networking/models/meals_model.dart';

abstract class MealState {}

class MealInitialState extends MealState {}

class MealLoading extends MealState {}

class MealError extends MealState {
  final String errorMesage;
  MealError(this.errorMesage);
}

class MealSuccess extends MealState {
  final MealModel mealModel;
  MealSuccess(this.mealModel);
}
