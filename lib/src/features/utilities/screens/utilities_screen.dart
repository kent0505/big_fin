import 'package:flutter/material.dart';

import '../../../core/widgets/tab_widget.dart';
import '../tabs/calculator_tab.dart';
import '../tabs/comparison_tab.dart';
import '../tabs/news_tab.dart';

class UtilitiesScreen extends StatelessWidget {
  const UtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      titles: [
        'Calculator',
        'Comparison',
        'News',
      ],
      pages: [
        CalculatorTab(),
        ComparisonTab(),
        NewsTab(),
      ],
    );
  }
}
