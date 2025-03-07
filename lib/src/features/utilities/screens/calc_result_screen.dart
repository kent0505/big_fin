import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class CalcResultScreen extends StatelessWidget {
  const CalcResultScreen({super.key});

  static const routePath = '/CalcResultScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Calculation Result'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [],
      ),
    );
  }
}
