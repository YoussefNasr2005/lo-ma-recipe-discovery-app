import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_food_app/core/networking/services/random_meals_service.dart';
import 'package:small_food_app/features/cubit/meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit() : super(InitialMealsState());

  Future<void> getMeals(String letter) async {
    emit(MealsLoading());
    try {
      final response = await RandomMealsService.searchByLetter(letter: letter);
      emit(MealsSuccess(response));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }
}
