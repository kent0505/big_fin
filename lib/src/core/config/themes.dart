import 'package:flutter/material.dart';

import 'constants.dart';
import 'my_colors.dart';

final _ligthColors = MyColors.light();
final _darkColors = MyColors.dark();

final lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.medium,
  brightness: Brightness.light,
  scaffoldBackgroundColor: _ligthColors.bg,
  colorScheme: ColorScheme.light(
    surface: _ligthColors.bg,
    secondary: _ligthColors.tertiaryFour, // overscroll indicator color
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _ligthColors.accent,
    selectionColor: _ligthColors.accent,
    selectionHandleColor: _ligthColors.accent,
  ),
  appBarTheme: AppBarTheme(
    toolbarHeight: 48,
    backgroundColor: _ligthColors.bg,
    titleTextStyle: TextStyle(
      color: _ligthColors.textPrimary,
      fontSize: 18,
      fontFamily: AppFonts.bold,
    ),
    centerTitle: true,
    elevation: 0,
    actionsPadding: EdgeInsets.symmetric(horizontal: 16),
  ),
  dialogTheme: const DialogTheme(
    insetPadding: EdgeInsets.zero,
    backgroundColor: Color(0xffB3B3B3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _ligthColors.tertiaryOne,
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    hintStyle: TextStyle(
      color: _ligthColors.textSecondary,
      fontSize: 14,
      fontFamily: AppFonts.medium,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _ligthColors.bg,
  ),
  extensions: [_ligthColors],
);

final darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.medium,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkColors.bg,
  colorScheme: ColorScheme.dark(
    surface: _darkColors.bg,
    secondary: _ligthColors.tertiaryFour, // overscroll indicator color
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _darkColors.accent,
    selectionColor: _darkColors.accent,
    selectionHandleColor: _darkColors.accent,
  ),
  appBarTheme: AppBarTheme(
    toolbarHeight: 48,
    backgroundColor: _darkColors.bg,
    titleTextStyle: TextStyle(
      color: _darkColors.textPrimary,
      fontSize: 18,
      fontFamily: AppFonts.bold,
    ),
    centerTitle: true,
    elevation: 0,
    actionsPadding: EdgeInsets.symmetric(horizontal: 16),
  ),
  dialogTheme: const DialogTheme(
    insetPadding: EdgeInsets.zero,
    backgroundColor: Color(0xff252525),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _darkColors.tertiaryOne,
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    hintStyle: TextStyle(
      color: _darkColors.textSecondary,
      fontSize: 14,
      fontFamily: AppFonts.medium,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _darkColors.bg,
  ),
  extensions: [_darkColors],
);
