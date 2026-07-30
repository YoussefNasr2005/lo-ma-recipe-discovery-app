import 'package:small_food_app/core/networking/models/meals_model.dart';

abstract class SearchState {}

class InitialSearchState extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError(this.errorMessage);
}

class SearchSuccess extends SearchState {
  final MealsModel mealsModel;
  SearchSuccess(this.mealsModel);
}
