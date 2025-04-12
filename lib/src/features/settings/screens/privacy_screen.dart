import 'package:flutter/material.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../widgets/settings_text.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const routePath = '/PrivacyScreen';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(title: l.privacyPolicy),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SettingsText('Privacy Policy'),
        ],
      ),
    );
  }
}
