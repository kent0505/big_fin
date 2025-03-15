import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        l.soon,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
          fontFamily: AppFonts.bold,
        ),
      ),
    );
  }
}
