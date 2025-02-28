import 'package:flutter/material.dart';

import 'constants.dart';

final theme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.medium,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.bg,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.main,
    selectionColor: AppColors.main,
    selectionHandleColor: AppColors.main,
  ),

  // APP BAR
  appBarTheme: AppBarTheme(
    toolbarHeight: 48,
    backgroundColor: AppColors.bg,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: AppFonts.bold,
    ),
    centerTitle: true,
    elevation: 0,
    actionsPadding: EdgeInsets.symmetric(horizontal: 16),
  ),

  // DIALOG
  dialogTheme: const DialogTheme(
    insetPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),

  // TEXTFIELD
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff1B1B1B),
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
      color: Color(0xffB0B0B0),
      fontSize: 14,
      fontFamily: AppFonts.medium,
    ),
  ),
);
