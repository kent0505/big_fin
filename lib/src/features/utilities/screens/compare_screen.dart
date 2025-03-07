import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  static const routePath = '/CompareScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Compare other'),
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
              title: 'Compare',
              active: false,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
