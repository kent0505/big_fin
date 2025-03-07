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
    required this.blue,
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
  final Color blue;
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
      blue: Color(0xff007AFF),
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
      blue: Color(0xff007AFF),
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
    Color? blue,
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
      blue: blue ?? this.blue,
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
      blue: Color.lerp(blue, other.blue, t)!,
      linear2: Color.lerp(linear2, other.linear2, t)!,
    );
  }
}
