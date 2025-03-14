import 'package:go_router/go_router.dart';

import '../../features/analytics/screens/analytics_cat_screen.dart';
import '../../features/budget/screens/add_budget_screen.dart';
import '../../features/budget/screens/add_limits_screen.dart';
import '../../features/budget/screens/budget_screen.dart';
import '../../features/category/screens/category_screen.dart';
import '../../features/category/screens/categories_screen.dart';
import '../../features/expense/screens/add_expense_screen.dart';
import '../../features/expense/screens/all_transactions_screen.dart';
import '../../features/expense/screens/expense_details_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/language/screens/language_screen.dart';
import '../../features/splash/screens/onboard_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/theme/screens/theme_screen.dart';
import '../../features/utils/screens/calc_history_screen.dart';
import '../../features/utils/screens/calc_result_screen.dart';
import '../../features/utils/screens/compare_screen.dart';
import '../../features/vip/screens/vip_screen.dart';
import '../models/budget.dart';
import '../models/calc.dart';
import '../models/expense.dart';
import '../models/cat.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: OnboardScreen.routePath,
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AllTransactionsScreen.routePath,
      builder: (context, state) => const AllTransactionsScreen(),
    ),
    GoRoute(
      path: AddExpenseScreen.routePath,
      builder: (context, state) => AddExpenseScreen(),
    ),
    GoRoute(
      path: ExpenseDetailsScreen.routePath,
      builder: (context, state) => ExpenseDetailsScreen(
        expense: state.extra as Expense,
      ),
    ),
    GoRoute(
      path: VipScreen.routePath,
      builder: (context, state) => const VipScreen(),
    ),
    GoRoute(
      path: ThemeScreen.routePath,
      builder: (context, state) => const ThemeScreen(),
    ),
    GoRoute(
      path: BudgetScreen.routePath,
      builder: (context, state) => const BudgetScreen(),
    ),
    GoRoute(
      path: AddBudgetScreen.routePath,
      builder: (context, state) => AddBudgetScreen(),
    ),
    GoRoute(
      path: AddLimitsScreen.routePath,
      builder: (context, state) => AddLimitsScreen(
        budget: state.extra as Budget,
      ),
    ),
    GoRoute(
      path: CategoriesScreen.routePath,
      builder: (context, state) => CategoriesScreen(),
    ),
    GoRoute(
      path: CategoryScreen.routePath,
      builder: (context, state) => CategoryScreen(
        cat: state.extra as Cat?,
      ),
    ),
    GoRoute(
      path: LanguageScreen.routePath,
      builder: (context, state) => LanguageScreen(),
    ),
    GoRoute(
      path: CalcHistoryScreen.routePath,
      builder: (context, state) => CalcHistoryScreen(),
    ),
    GoRoute(
      path: CalcResultScreen.routePath,
      builder: (context, state) => CalcResultScreen(
        calc: state.extra as Calc,
      ),
    ),
    GoRoute(
      path: CompareScreen.routePath,
      builder: (context, state) => CompareScreen(),
    ),
    GoRoute(
      path: AnalyticsCatScreen.routePath,
      builder: (context, state) => AnalyticsCatScreen(
        cat: state.extra as Cat,
      ),
    ),
  ],
);
