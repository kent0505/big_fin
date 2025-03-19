import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
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
    context.read<AssistantBloc>().add(
          SentMessage(
            chat: widget.chat,
            message: Message(
              id: getTimestamp(),
              chatID: widget.chat.id,
              message: chatController.text,
              fromGPT: false,
            ),
          ),
        );
    chatController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 500), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AssistantBloc>().add(LoadMessages(chat: widget.chat));
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
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

    // Future.microtask(() => _scrollToBottom());

    return Scaffold(
      appBar: Appbar(title: l.chat),
      body: Stack(
        children: [
          ChatBg(),
          Padding(
            padding: const EdgeInsets.only(bottom: 102),
            child: BlocBuilder<AssistantBloc, AssistantState>(
              builder: (context, state) {
                if (state is ChatsLoaded) {
                  if (state.messages.isEmpty) {
                    if (widget.chat.title.isEmpty) {
                      return ChatHello(chat: widget.chat);
                    }
                  }

                  return ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return ChatMessage(
                        message: state.messages[index],
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
          ChatField(
            controller: chatController,
            onSend: onSend,
          ),
        ],
      ),
    );
  }
}
