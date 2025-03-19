import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/assistant_bloc.dart';
import '../widgets/chat_card.dart';
import '../widgets/new_chat_button.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<AssistantBloc, AssistantState>(
          builder: (context, state) {
            return state is ChatsLoaded
                ? ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      return ChatCard(
                        chat: state.chats.reversed.toList()[index],
                      );
                    },
                  )
                : const SizedBox();
          },
        ),
        NewChatButton(),
      ],
    );
  }
}
