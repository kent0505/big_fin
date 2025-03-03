import 'package:flutter/material.dart';

import 'constants.dart';
import 'my_colors.dart';

// final colors = Theme.of(context).extension<MyColors>()!;

final lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.medium,
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColors.light().bg,
  colorScheme: ColorScheme.light(
    surface: MyColors.light().bg,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: MyColors.light().accent,
    selectionColor: MyColors.light().accent,
    selectionHandleColor: MyColors.light().accent,
  ),
  appBarTheme: AppBarTheme(
    toolbarHeight: 48,
    backgroundColor: MyColors.light().bg,
    titleTextStyle: TextStyle(
      color: MyColors.light().textPrimary,
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
    fillColor: MyColors.light().tertiaryOne,
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
      color: MyColors.light().textSecondary,
      fontSize: 14,
      fontFamily: AppFonts.medium,
    ),
  ),
  extensions: [
    MyColors.light(),
  ],
);

final darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.medium,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.dark().bg,
  colorScheme: ColorScheme.dark(
    surface: MyColors.dark().bg,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: MyColors.dark().accent,
    selectionColor: MyColors.dark().accent,
    selectionHandleColor: MyColors.dark().accent,
  ),
  appBarTheme: AppBarTheme(
    toolbarHeight: 48,
    backgroundColor: MyColors.dark().bg,
    titleTextStyle: TextStyle(
      color: MyColors.dark().textPrimary,
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
    fillColor: MyColors.dark().tertiaryOne,
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
      color: MyColors.dark().textSecondary,
      fontSize: 14,
      fontFamily: AppFonts.medium,
    ),
  ),
  extensions: [
    MyColors.dark(),
  ],
);
