import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../bloc/assistant_bloc.dart';
import '../widgets/chat_bg.dart';
import '../widgets/chat_field.dart';
import '../widgets/chat_hello.dart';
import '../widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chat});

  final Chat chat;

  static const routePath = '/ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final chatController = TextEditingController();

  void onSend() {
    if (chatController.text.isEmpty) return;
    final message = chatController.text;
    final locale = Localizations.localeOf(context).languageCode;
    logger(locale);
    chatController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<AssistantBloc>().add(
              SentMessage(
                chat: widget.chat,
                message: Message(
                  id: getTimestamp(),
                  chatID: widget.chat.id,
                  message: message,
                  fromGPT: false,
                ),
                locale: locale,
              ),
            );
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  void onFinished() {
    logger('onFinished');
    context.read<AssistantBloc>().add(LoadMessages(chat: widget.chat));
  }

  @override
  void initState() {
    super.initState();
    context.read<AssistantBloc>().add(LoadMessages(chat: widget.chat));
  }

  @override
  void dispose() {
    scrollController.dispose();
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(title: l.chat),
      body: Stack(
        children: [
          ChatBg(),
          Column(
            children: [
              Expanded(
                child: BlocConsumer<AssistantBloc, AssistantState>(
                  listener: (context, state) {
                    logger(state.runtimeType);
                  },
                  builder: (context, state) {
                    if (state is ChatsLoaded) {
                      final messages = state.messages.reversed.toList();

                      if (messages.isEmpty) {
                        return ChatHello(chat: widget.chat);
                      }

                      return ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.all(16),
                        reverse: true,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                            messages.last.id,
                          );
                          final now = DateTime.now();
                          final today = now.year == date.year &&
                              now.month == date.month &&
                              now.day == date.day;

                          if (index == messages.length) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: colors.textThree,
                                    ),
                                  ),
                                  SizedBox(width: 22),
                                  Text(
                                    today
                                        ? '${l.today}, ${timeToString(date)}'
                                        : timeToString(date),
                                    style: TextStyle(
                                      color: colors.textThree,
                                    ),
                                  ),
                                  SizedBox(width: 22),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: colors.textThree,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (messages[index].message.isEmpty) {
                            return const Row(
                              children: [
                                SizedBox(
                                  height: 12,
                                  child: LoadingWidget(),
                                ),
                              ],
                            );
                          }

                          return ChatMessage(
                            message: messages[index],
                            animated: state.loading &&
                                messages[index].id == messages.first.id,
                            onFinished: onFinished,
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              BlocBuilder<AssistantBloc, AssistantState>(
                builder: (context, state) {
                  return state is ChatsLoaded && !state.loading
                      ? ChatField(
                          controller: chatController,
                          onSend: onSend,
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
