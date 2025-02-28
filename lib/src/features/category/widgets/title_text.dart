import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: AppFonts.bold,
      ),
    );
  }
}
