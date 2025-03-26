import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/chat.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../screens/chat_screen.dart';

class NewChatButton extends StatelessWidget {
  const NewChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Positioned(
      right: 16,
      bottom: 16,
      child: Button(
        onPressed: () {
          context.push(
            ChatScreen.routePath,
            extra: Chat(
              id: getTimestamp(),
              title: '',
            ),
          );
        },
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              SizedBox(width: 34),
              Text(
                l.newChat,
                style: TextStyle(
                  color: colors.bg,
                  fontSize: 18,
                  fontFamily: AppFonts.bold,
                ),
              ),
              SizedBox(width: 4),
              SvgWidget(
                Assets.pen,
                width: 24,
                color: colors.bg,
              ),
              SizedBox(width: 34),
            ],
          ),
        ),
      ),
    );
  }
}
