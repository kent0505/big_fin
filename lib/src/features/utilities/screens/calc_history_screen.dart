import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class CalcHistoryScreen extends StatelessWidget {
  const CalcHistoryScreen({super.key});

  static const routePath = '/CalcHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Calculation History'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [],
      ),
    );
  }
}
