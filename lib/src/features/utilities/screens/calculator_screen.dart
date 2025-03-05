import 'package:flutter/material.dart';

import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final powerController = TextEditingController();
  final timeController = TextEditingController();
  final tariffController = TextEditingController();

  @override
  void dispose() {
    powerController.dispose();
    timeController.dispose();
    tariffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const TitleText('Device Power (W)'),
        const SizedBox(height: 6),
        TxtField(
          controller: powerController,
          hintText: 'Ex: 150',
          number: true,
        ),
        const SizedBox(height: 12),
        const TitleText('Operating Time'),
        const SizedBox(height: 6),
        TxtField(
          controller: timeController,
          hintText: 'Ex: 150',
          number: true,
        ),
        const SizedBox(height: 12),
        const TitleText('Tariff'),
        const SizedBox(height: 6),
        TxtField(
          controller: tariffController,
          hintText: 'Ex: 150',
          number: true,
        ),
        const SizedBox(height: 24),
        MainButton(
          title: 'Calculate',
          active: false,
          onPressed: () {},
        ),
      ],
    );
  }
}
