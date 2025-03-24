import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';

class ChatField extends StatelessWidget {
  const ChatField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.bottomCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.bg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: TxtField(
                    controller: controller,
                    hintText: l.chatHint,
                    multiline: true,
                    close: false,
                    maxLength: 400,
                  ),
                ),
                SizedBox(width: 4),
                Button(
                  onPressed: onSend,
                  child: SvgWidget(
                    Assets.send,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}
