import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class ChatDateText extends StatelessWidget {
  const ChatDateText({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        '${l.today}, 09.02.2025',
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 12,
          fontFamily: AppFonts.medium,
        ),
      ),
    );
  }
}
