import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/widgets/tab_widget.dart';
import '../tabs/calculator_tab.dart';
import '../tabs/comparison_tab.dart';
import '../tabs/news_tab.dart';

class UtilsScreen extends StatelessWidget {
  const UtilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return TabWidget(
      titles: [
        l.calculator,
        l.comparison,
        l.news,
      ],
      pages: [
        CalculatorTab(),
        ComparisonTab(),
        NewsTab(),
      ],
    );
  }
}
