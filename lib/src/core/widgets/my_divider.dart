import 'package:flutter/material.dart';

import '../config/my_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return SizedBox(
      height: 8,
      child: Center(
        child: Container(
          height: 0.5,
          color: colors.tertiaryFour,
        ),
      ),
    );
  }
}
