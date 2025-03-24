import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/message.dart';
import '../../../core/widgets/snack_widget.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.message,
    required this.animated,
    required this.onFinished,
  });

  final Message message;
  final bool animated;
  final void Function() onFinished;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment:
          message.fromGPT ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 266),
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: message.fromGPT ? colors.tertiaryOne : colors.tertiaryFour,
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: message.message));
                SnackWidget.show(context, l.copiedToClipboard);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: animated && message.fromGPT
                    ? AnimatedTextKit(
                        isRepeatingAnimation: false,
                        onFinished: onFinished,
                        animatedTexts: [
                          TyperAnimatedText(
                            message.message.trim(),
                            speed: Duration(milliseconds: 10),
                          ),
                        ],
                      )
                    : Text(
                        message.message.trim(),
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontFamily: AppFonts.medium,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
