import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Appbar(title: 'Add category'),
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
