import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import 'src/core/config/router.dart';
import 'src/core/config/themes.dart';
import 'src/core/config/constants.dart';
import 'src/core/config/my_colors.dart';
import 'src/features/analytics/bloc/analytics_bloc.dart';
import 'src/features/assistant/bloc/assistant_bloc.dart';
import 'src/features/assistant/data/assistant_repository.dart';
import 'src/features/settings/bloc/settings_bloc.dart';
import 'src/features/settings/data/settings_repository.dart';
import 'src/features/splash/data/onboard_repository.dart';
import 'src/features/theme/data/theme_repository.dart';
import 'src/features/language/data/language_repository.dart';
import 'src/features/expense/data/expense_repository.dart';
import 'src/features/category/data/category_repository.dart';
import 'src/features/budget/data/budget_repository.dart';
import 'src/features/utils/data/utils_repository.dart';
import 'src/features/home/bloc/home_bloc.dart';
import 'src/features/expense/bloc/expense_bloc.dart';
import 'src/features/category/bloc/category_bloc.dart';
import 'src/features/theme/bloc/theme_bloc.dart';
import 'src/features/language/bloc/language_bloc.dart';
import 'src/features/budget/bloc/budget_bloc.dart';
import 'src/features/utils/bloc/utils_bloc.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
  try {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // DIO
    final dio = Dio();

    // PREFS
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    // await prefs.remove(Keys.onboard);

    // SQFLITE
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Tables.db);
    // await deleteDatabase(path);
    final db = await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int version) async {
        await db.execute(SQL.expenses);
        await db.execute(SQL.categories);
        await db.execute(SQL.budgets);
        await db.execute(SQL.calcs);
        await db.execute(SQL.chats);
        await db.execute(SQL.messages);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS ${Tables.expenses}');
          await db.execute(SQL.expenses);
        } else if (oldVersion < 3) {
          await db.execute('DROP TABLE IF EXISTS ${Tables.budgets}');
          await db.execute(SQL.budgets);
        }
      },
    );

    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<OnboardRepository>(
            create: (context) => OnboardRepositoryImpl(prefs: prefs),
          ),
          RepositoryProvider<ThemeRepository>(
            create: (context) => ThemeRepositoryImpl(prefs: prefs),
          ),
          RepositoryProvider<LanguageRepository>(
            create: (context) => LanguageRepositoryImpl(prefs: prefs),
          ),
          RepositoryProvider<ExpenseRepository>(
            create: (context) => ExpenseRepositoryImpl(db: db),
          ),
          RepositoryProvider<CategoryRepository>(
            create: (context) => CategoryRepositoryImpl(db: db),
          ),
          RepositoryProvider<BudgetRepository>(
            create: (context) => BudgetRepositoryImpl(db: db),
          ),
          RepositoryProvider<UtilsRepository>(
            create: (context) => UtilsRepositoryImpl(db: db),
          ),
          RepositoryProvider<AssistantRepository>(
            create: (context) => AssistantRepositoryImpl(
              prefs: prefs,
              db: db,
              dio: dio,
            ),
          ),
          RepositoryProvider<SettingsRepository>(
            create: (context) => SettingsRepositoryImpl(
              prefs: prefs,
              db: db,
              path: path,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => AnalyticsBloc()),
            BlocProvider(
              create: (context) => ExpenseBloc(
                repository: context.read<ExpenseRepository>(),
              )..add(GetExpenses()),
            ),
            BlocProvider(
              create: (context) => CategoryBloc(
                repository: context.read<CategoryRepository>(),
              )..add(GetCategories()),
            ),
            BlocProvider(
              create: (context) => ThemeBloc(
                repository: context.read<ThemeRepository>(),
              )..add(GetTheme()),
            ),
            BlocProvider(
              create: (context) => LanguageBloc(
                repository: context.read<LanguageRepository>(),
              )..add(GetLanguage()),
            ),
            BlocProvider(
              create: (context) => BudgetBloc(
                repository: context.read<BudgetRepository>(),
              )..add(GetBudgets()),
            ),
            BlocProvider(
              create: (context) => UtilsBloc(
                repository: context.read<UtilsRepository>(),
              )..add(GetCalcResults()),
            ),
            BlocProvider(
              create: (context) => AssistantBloc(
                repository: context.read<AssistantRepository>(),
              )..add(LoadChats()),
            ),
            BlocProvider(
              create: (context) => SettingsBloc(
                repository: context.read<SettingsRepository>(),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    );
  } on Object catch (error, stackTrace) {
    Error.safeToString(error);
    stackTrace.toString();
    rethrow;
  } finally {
    binding.allowFirstFrame();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LanguageBloc, Locale>(
          builder: (context, locale) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              themeMode: themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              routerConfig: routerConfig,
            );
          },
        );
      },
    );
  }
}
