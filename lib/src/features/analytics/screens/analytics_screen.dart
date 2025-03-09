import 'package:flutter/material.dart';

import '../../../core/widgets/tab_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      titles: ['Week', 'Month', 'Year', 'Custom'],
      pages: [
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
      ],
    );
  }
}
