import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Appbar(title: 'Analytics', back: false),
        Expanded(
          child: ListView(
            children: [],
          ),
        ),
      ],
    );
  }
}
