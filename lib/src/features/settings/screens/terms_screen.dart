import 'package:flutter/material.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../widgets/settings_text.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const routePath = '/TermsScreen';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(title: l.termsOfUse),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SettingsText('Terms of Use'),
        ],
      ),
    );
  }
}
