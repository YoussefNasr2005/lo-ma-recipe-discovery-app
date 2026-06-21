import 'package:go_router/go_router.dart';
import 'package:small_food_app/core/networking/models/meals_model.dart';
import 'package:small_food_app/features/screens/favourite_page.dart';
import 'package:small_food_app/features/screens/meal_details.dart';
import 'package:small_food_app/features/screens/meals_home.dart';
import 'package:small_food_app/features/screens/onboarding_screen.dart';
import 'package:small_food_app/features/screens/search_result.dart';
import 'package:small_food_app/routing/app_routes.dart';

class RouterGeneration {
  static bool isFirstLogin = true;
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.mealsHome,
    redirect: (context, state) {
      if (state.matchedLocation == AppRoutes.mealsHome && isFirstLogin) {
        return AppRoutes.onBoardingScreen;
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        name: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.mealsHome,
        name: AppRoutes.mealsHome,
        builder: (context, state) => const MealsHome(),
      ),
      GoRoute(
        path: AppRoutes.searchResult,
        name: AppRoutes.searchResult,
        builder: (context, state) =>
            SearchResult(searchName: state.extra as String),
      ),
      GoRoute(
        path: AppRoutes.mealDetailsScreen,
        name: AppRoutes.mealDetailsScreen,
        builder: (context, state) =>
            MealDetailsScreen(meal: state.extra as MealModel),
      ),
      GoRoute(
        path: AppRoutes.favouritePage,
        name: AppRoutes.favouritePage,
        builder: (context, state) => const FavouritePage(),
      ),
    ],
  );
}
