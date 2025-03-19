import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/chat.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/assistant_bloc.dart';
import '../screens/chat_screen.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Container(
      height: 88,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Button(
            onPressed: () {
              context.push(ChatScreen.routePath, extra: chat);
            },
            child: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '22:10',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 14,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          Positioned(
            right: 6,
            child: Button(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWidget(
                      title: l.areYouSure,
                      description: l.deleteDescription,
                      leftTitle: l.delete,
                      rightTitle: l.cancel,
                      onYes: () {
                        context
                            .read<AssistantBloc>()
                            .add(DeleteChat(chat: chat));
                      },
                    );
                  },
                );
              },
              child: SvgWidget(
                Assets.delete,
                color: colors.textThree,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
