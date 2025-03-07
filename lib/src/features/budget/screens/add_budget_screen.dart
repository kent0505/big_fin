import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';
import 'add_limits_screen.dart';

class AddBudgetScreen extends StatelessWidget {
  const AddBudgetScreen({super.key});

  static const routePath = '/AddBudgetScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Add budget'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: 'Next',
              onPressed: () {
                context.push(AddLimitsScreen.routePath);
              },
            ),
          ),
        ],
      ),
    );
  }
}
