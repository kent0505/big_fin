import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'src/core/utils.dart';
import 'src/core/config/router.dart';
import 'src/core/config/themes.dart';
import 'src/core/config/constants.dart';
import 'src/features/home/bloc/home_bloc.dart';
import 'src/features/expense/bloc/expense_bloc.dart';
import 'src/features/category/bloc/category_bloc.dart';
import 'src/features/splash/data/onboard_repository.dart';
import 'src/features/expense/data/expense_repository.dart';
import 'src/features/category/data/category_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'data.db');
  // await deleteDatabase(path);
  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      logger('ON CREATE');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Keys.expensesTable} (
          id INTEGER NOT NULL,
          date TEXT NOT NULL,
          time TEXT NOT NULL,
          title TEXT NOT NULL,
          amount TEXT NOT NULL,
          note TEXT NOT NULL,
          catTitle TEXT NOT NULL,
          assetID INTEGER NOT NULL,
          colorID INTEGER NOT NULL,
          isIncome INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Keys.categoriesTable} (
          id INTEGER NOT NULL,
          title TEXT NOT NULL,
          assetID INTEGER NOT NULL,
          colorID INTEGER NOT NULL
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
        RepositoryProvider<ExpenseRepository>(
          create: (context) => ExpenseRepositoryImpl(db: db),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepositoryImpl(db: db),
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
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(Assets.onb1), context);
    precacheImage(AssetImage(Assets.onb2), context);
    precacheImage(AssetImage(Assets.onb3), context);
    precacheImage(AssetImage(Assets.onb4), context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: routerConfig,
    );
  }
}
