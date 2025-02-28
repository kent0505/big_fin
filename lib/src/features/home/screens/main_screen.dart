import 'package:flutter/material.dart';

import '../widgets/add_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/overview_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.all(16),
          children: [
            BalanceCard(),
            const SizedBox(height: 8),
            OverviewWidget(),
            SizedBox(height: 48) // categories list
          ],
        ),
        AddButton(),
      ],
    );
  }
}
