import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/config/router.dart';
import 'src/core/config/themes.dart';
import 'src/core/config/constants.dart';
import 'src/features/home/blocs/navbar/navbar_bloc.dart';
import 'src/features/splash/data/onboard_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavbarBloc()),
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
