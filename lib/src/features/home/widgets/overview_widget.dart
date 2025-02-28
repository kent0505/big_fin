import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: AppFonts.bold,
          ),
        ),
        Spacer(),
        Button(
          onPressed: () {},
          child: SvgWidget(Assets.calendar),
        ),
      ],
    );
  }
}
