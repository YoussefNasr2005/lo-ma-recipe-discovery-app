import 'package:small_food_app/core/networking/models/meals_model.dart';

abstract class MealsState {}

class InitialMealsState extends MealsState {}
class MealsLoading extends MealsState {}

class MealsSuccess extends MealsState {
  final MealsModel meals;

  MealsSuccess(this.meals);
}

class MealsError extends MealsState {
  final String message;

  MealsError(this.message);
}