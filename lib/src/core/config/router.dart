import 'package:go_router/go_router.dart';

import '../../features/budget/screens/budget_screen.dart';
import '../../features/category/models/cat.dart';
import '../../features/category/screens/category_screen.dart';
import '../../features/category/screens/categories_screen.dart';
import '../../features/expense/models/expense.dart';
import '../../features/expense/screens/add_expense_screen.dart';
import '../../features/expense/screens/all_transactions_screen.dart';
import '../../features/expense/screens/expense_details_screen.dart';
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
      path: AppRoutes.allTransactions,
      builder: (context, state) => const AllTransactionsScreen(),
    ),
    GoRoute(
      path: AppRoutes.addExpense,
      builder: (context, state) => AddExpenseScreen(),
    ),
    GoRoute(
      path: AppRoutes.expenseDetails,
      builder: (context, state) => ExpenseDetailsScreen(
        expense: state.extra as Expense,
      ),
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
      path: AppRoutes.categories,
      builder: (context, state) => CategoriesScreen(),
    ),
    GoRoute(
      path: AppRoutes.category,
      builder: (context, state) => CategoryScreen(
        cat: state.extra as Cat?,
      ),
    ),
  ],
);

abstract final class AppRoutes {
  static const home = '/home';
  static const allTransactions = '/allTransactions';
  static const addExpense = '/addExpense';
  static const expenseDetails = '/expenseDetails';

  static const onboard = '/onboard';
  static const vip = '/vip';

  static const budget = '/budget';
  static const categories = '/categories';
  static const category = '/category';
  static const theme = '/theme';
}
