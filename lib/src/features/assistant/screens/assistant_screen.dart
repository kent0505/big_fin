import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Appbar(title: 'AI Assistan', back: false),
        Expanded(
          child: ListView(
            children: [],
          ),
        ),
      ],
    );
  }
}
