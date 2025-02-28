import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class UtilitiesScreen extends StatelessWidget {
  const UtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Appbar(title: 'Utilities', back: false),
        Expanded(
          child: ListView(
            children: [],
          ),
        ),
      ],
    );
  }
}
