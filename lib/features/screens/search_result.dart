import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/core/networking/services/search_service.dart';
import 'package:small_food_app/core/widgets/custom_futurebuilder_widget.dart';
import 'package:small_food_app/core/widgets/meal_card_widget.dart';

class SearchResult extends StatefulWidget {
  final String searchName;
  const SearchResult({super.key, required this.searchName});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late Future<MealsModel> _mealsFuture;
  @override
  void initState() {
    super.initState();
    _mealsFuture = SearchService.searchByName(name: widget.searchName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة البحث'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),

        child: CustomFuturebuilderWidget(
          mealCard: (MealModel meal) => MealCardWidget(meal: meal),
          mealsFutureBuilder: _mealsFuture,
          isMainCard: false,
        ),
      ),
    );
  }
}
