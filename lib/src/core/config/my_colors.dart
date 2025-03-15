import 'package:flutter/material.dart';

final class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.bg,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textThree,
    required this.tertiaryOne,
    required this.tertiaryTwo,
    required this.tertiaryThree,
    required this.tertiaryFour,
    required this.system,
    required this.orange,
    required this.blue,
    required this.yellow,
    required this.violet,
    required this.green,
    required this.shopping,
    required this.linear2,
  });

  final Color bg;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textThree;
  final Color tertiaryOne;
  final Color tertiaryTwo;
  final Color tertiaryThree;
  final Color tertiaryFour;
  final Color system;
  final Color orange;
  final Color blue;
  final Color yellow;
  final Color violet;
  final Color green;
  final Color shopping;
  final Color linear2;

  factory MyColors.dark() {
    return MyColors(
      bg: Color(0xff121212),
      accent: Color(0xff41fda9),
      textPrimary: Color(0xfffdfdfd),
      textSecondary: Color(0xffb0b0b0),
      textThree: Color(0xff535353),
      tertiaryOne: Color(0xff1b1b1b),
      tertiaryTwo: Color(0xff1a382a),
      tertiaryThree: Color(0xff485c53),
      tertiaryFour: Color(0xff313131),
      system: Color(0xffff3b30),
      orange: Color(0xffff9500),
      blue: Color(0xff007AFF),
      yellow: Color(0xffd4ff00),
      violet: Color(0xffaf52de),
      green: Color(0xff34c759),
      shopping: Color(0xffff2d55),
      linear2: Color(0xff052B22),
    );
  }

  factory MyColors.light() {
    return MyColors(
      bg: Color(0xffFDFDFD),
      accent: Color(0xff24F597),
      textPrimary: Color(0xff121212),
      textSecondary: Color(0xffb0b0b0),
      textThree: Color(0xff909090),
      tertiaryOne: Color(0xffF6F6F6),
      tertiaryTwo: Color(0xffE6FFF3),
      tertiaryThree: Color(0xff97A19D),
      tertiaryFour: Color(0xffEFEFEF),
      system: Color(0xffff3b30),
      orange: Color(0xffff9500),
      blue: Color(0xff007AFF),
      yellow: Color(0xffd4ff00),
      violet: Color(0xffaf52de),
      green: Color(0xff34c759),
      shopping: Color(0xffff2d55),
      linear2: Color(0xffE2FFF8),
    );
  }

  @override
  MyColors copyWith({
    Color? bg,
    Color? accent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textThree,
    Color? tertiaryOne,
    Color? tertiaryTwo,
    Color? tertiaryThree,
    Color? tertiaryFour,
    Color? system,
    Color? orange,
    Color? blue,
    Color? yellow,
    Color? violet,
    Color? green,
    Color? shopping,
    Color? linear2,
  }) {
    return MyColors(
      bg: bg ?? this.bg,
      accent: accent ?? this.accent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textThree: textThree ?? this.textThree,
      tertiaryOne: tertiaryOne ?? this.tertiaryOne,
      tertiaryTwo: tertiaryTwo ?? this.tertiaryTwo,
      tertiaryThree: tertiaryThree ?? this.tertiaryThree,
      tertiaryFour: tertiaryFour ?? this.tertiaryFour,
      system: system ?? this.system,
      orange: orange ?? this.orange,
      blue: blue ?? this.blue,
      yellow: yellow ?? this.yellow,
      violet: violet ?? this.violet,
      green: green ?? this.green,
      shopping: shopping ?? this.shopping,
      linear2: linear2 ?? this.linear2,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      bg: Color.lerp(bg, other.bg, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textThree: Color.lerp(textThree, other.textThree, t)!,
      tertiaryOne: Color.lerp(tertiaryOne, other.tertiaryOne, t)!,
      tertiaryTwo: Color.lerp(tertiaryTwo, other.tertiaryTwo, t)!,
      tertiaryThree: Color.lerp(tertiaryThree, other.tertiaryThree, t)!,
      tertiaryFour: Color.lerp(tertiaryFour, other.tertiaryFour, t)!,
      system: Color.lerp(system, other.system, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      violet: Color.lerp(violet, other.violet, t)!,
      green: Color.lerp(green, other.green, t)!,
      shopping: Color.lerp(shopping, other.shopping, t)!,
      linear2: Color.lerp(linear2, other.linear2, t)!,
    );
  }
}

Color? getCatColor(int id) {
  if (id == 1) return Color(0xffC028BB);
  if (id == 2) return Color(0xffC02846);
  if (id == 3) return Color(0xff9228C0);
  if (id == 4) return Color(0xff4628C0);
  if (id == 5) return Color(0xff289FC0);
  if (id == 6) return Color(0xff28C088);
  if (id == 7) return Color(0xff28C028);
  if (id == 8) return Color(0xffCFD824);
  if (id == 9) return Color(0xffD89924);
  if (id == 10) return Color(0xffD86024);
  return null;
}
