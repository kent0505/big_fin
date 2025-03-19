import 'package:flutter/material.dart';

import '../../../core/config/my_colors.dart';

class ChatBg extends StatelessWidget {
  const ChatBg({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.bg,
            colors.linear2,
          ],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
