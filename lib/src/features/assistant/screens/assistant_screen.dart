import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    return Center(
      child: Text(
        'Soon!',
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
          fontFamily: AppFonts.bold,
        ),
      ),
    );
    // return ListView(
    //   children: [],
    // );
  }
}
