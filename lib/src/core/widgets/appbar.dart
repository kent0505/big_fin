import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    this.title = '',
    this.right,
    this.child,
  });

  final String title;
  final Widget? right;
  final Widget? child;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AppBar(
      title: child ?? Text(title),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Button(
          onPressed: () {
            context.pop();
          },
          child: SvgWidget(
            Assets.back,
            color: colors.textPrimary,
          ),
        ),
      ),
      actions: [right ?? const SizedBox()],
    );
  }
}
