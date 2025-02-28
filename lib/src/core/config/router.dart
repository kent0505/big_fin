import 'package:go_router/go_router.dart';

import '../../features/budget/screens/budget_screen.dart';
import '../../features/category/screens/add_category_screen.dart';
import '../../features/category/screens/category_screen.dart';
import '../../features/expense/screens/create_expense_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/splash/screens/onboard_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/theme/screens/theme_screen.dart';
import '../../features/vip/screens/vip_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboard,
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.createExpense,
      builder: (context, state) => const CreateExpenseScreen(),
    ),
    GoRoute(
      path: AppRoutes.vip,
      builder: (context, state) => const VipScreen(),
    ),
    GoRoute(
      path: AppRoutes.theme,
      builder: (context, state) => const ThemeScreen(),
    ),
    GoRoute(
      path: AppRoutes.budget,
      builder: (context, state) => const BudgetScreen(),
    ),
    GoRoute(
      path: AppRoutes.category,
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.addCategory,
      builder: (context, state) => const AddCategoryScreen(),
    ),
  ],
);

abstract final class AppRoutes {
  static const home = '/home';
  static const createExpense = '/create_expense';

  static const onboard = '/onboard';
  static const vip = '/vip';

  static const budget = '/budget';
  static const category = '/category';
  static const addCategory = '/add_category';
  static const theme = '/theme';
}
