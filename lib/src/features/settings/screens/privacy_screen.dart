import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        padding: EdgeInsets.all(16),
        children: [
          SettingsText('Privacy Policy'),
        ],
      ),
    );
  }
}
