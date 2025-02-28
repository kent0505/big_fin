import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Appbar(
            title: 'Budgets',
            onAdd: () {},
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
