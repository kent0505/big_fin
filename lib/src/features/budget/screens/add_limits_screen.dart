import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';

class AddLimitsScreen extends StatelessWidget {
  const AddLimitsScreen({super.key});

  static const routePath = '/AddLimitsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Add limits'),
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
              title: 'Save',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
