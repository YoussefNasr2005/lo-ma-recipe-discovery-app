import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_food_app/core/networking/services/search_service.dart';
import 'package:small_food_app/features/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearchState());

  Future<void> searchMeals(String searchName) async {
    emit(SearchLoading());
    try {
      final response = await SearchService.searchByName(name: searchName);
      emit(SearchSuccess(response));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
