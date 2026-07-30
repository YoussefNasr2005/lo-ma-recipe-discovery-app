import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_food_app/core/networking/services/random_meal_service.dart';
import 'package:small_food_app/features/cubit/meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitialState());

  Future<void> getRandomMeal() async {
    emit(MealLoading());
    try {
      final response = await RandomMealService.getRandomMeal();
      emit(MealSuccess(response));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}
