import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'src/core/utils.dart';
import 'src/core/config/router.dart';
import 'src/core/config/themes.dart';
import 'src/core/config/constants.dart';
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

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// final l = AppLocalizations.of(context)!;
// final colors = Theme.of(context).extension<MyColors>()!;

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
  try {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Tables.db);
    // await deleteDatabase(path);
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        logger('ON CREATE');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Tables.expenses} (
          id INTEGER NOT NULL,
          date TEXT NOT NULL,
          time TEXT NOT NULL,
          title TEXT NOT NULL,
          amount TEXT NOT NULL,
          note TEXT NOT NULL,
          attachment1 TEXT NOT NULL,
          attachment2 TEXT NOT NULL,
          attachment3 TEXT NOT NULL,
          catTitle TEXT NOT NULL,
          assetID INTEGER NOT NULL,
          colorID INTEGER NOT NULL,
          isIncome INTEGER NOT NULL
        )
      ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Tables.categories} (
          id INTEGER NOT NULL,
          title TEXT NOT NULL,
          assetID INTEGER NOT NULL,
          colorID INTEGER NOT NULL
        )
      ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Tables.budgets} (
          id INTEGER NOT NULL,
          monthly INTEGER NOT NULL,
          date TEXT NOT NULL,
          amount TEXT NOT NULL,
          cats TEXT NOT NULL
        )
      ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Tables.calcs} (
          id INTEGER NOT NULL,
          energy TEXT NOT NULL,
          cost TEXT NOT NULL,
          currency TEXT NOT NULL
        )
      ''');
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
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeBloc()),
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
          ],
          child: MyApp(),
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
