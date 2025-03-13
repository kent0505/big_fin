import 'package:big_fin/src/core/config/router.dart';
import 'package:big_fin/src/core/config/themes.dart';
import 'package:big_fin/src/features/language/bloc/language_bloc.dart';
import 'package:big_fin/src/features/theme/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeInitial, ThemeState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themeMode =
            state is ThemeInitial ? state.themeMode : ThemeMode.system;

        return BlocBuilder<LanguageBloc, Locale>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state,
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
