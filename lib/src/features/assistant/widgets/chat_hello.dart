import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../bloc/assistant_bloc.dart';

class ChatHello extends StatelessWidget {
  const ChatHello({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          l.chatHello,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 32,
            fontFamily: AppFonts.bold,
          ),
        ),
        SizedBox(height: 26),
        _Question(
          title: l.chatQuestion1,
          color: colors.accent,
          chat: chat,
        ),
        _Question(
          title: l.chatQuestion2,
          color: colors.accent,
          chat: chat,
        ),
        _Question(
          title: l.chatQuestion3,
          color: colors.violet,
          chat: chat,
        ),
        _Question(
          title: l.chatQuestion4,
          color: colors.violet,
          chat: chat,
        ),
        _Question(
          title: l.chatQuestion5,
          color: colors.blue,
          chat: chat,
        ),
        _Question(
          title: l.chatQuestion6,
          color: colors.blue,
          chat: chat,
        ),
      ],
    );
  }
}

class _Question extends StatelessWidget {
  const _Question({
    required this.title,
    required this.color,
    required this.chat,
  });

  final String title;
  final Color color;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 56,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.read<AssistantBloc>().add(
                SentMessage(
                  chat: chat,
                  message: Message(
                    id: getTimestamp(),
                    chatID: chat.id,
                    message: title,
                    fromGPT: false,
                  ),
                ),
              );
        },
        child: Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
