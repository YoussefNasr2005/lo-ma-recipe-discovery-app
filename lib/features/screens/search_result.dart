import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_food_app/core/widgets/main_home_card_widget.dart';
import 'package:small_food_app/features/cubit/search_cubit.dart';
import 'package:small_food_app/features/cubit/search_state.dart';

class SearchResult extends StatefulWidget {
  final String searchName;
  const SearchResult({super.key, required this.searchName});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().searchMeals(widget.searchName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة البحث'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),

        child: BlocBuilder<SearchCubit, SearchState>(
          builder: ((context, state) {
            if (state is SearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SearchError) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is SearchSuccess) {
              final meals = state.mealsModel.meals;
              if (meals.isEmpty) {
                return const Center(
                  child: Text('لا يوجد اي وجبات من هذا النوع.'),
                );
              } else {
                return GridView.builder(
                  itemBuilder: (context, index) {
                    return MainHomeCardWidget(meal: meals[index]);
                  },
                  itemCount: meals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.h,
                    mainAxisSpacing: 5.w,
                    childAspectRatio: .8,
                  ),
                );
              }
            }
            return const Center(child: Text('!لقد حدث شيء ما خطاء'));
          }),
        ),
      ),
    );
  }
}
