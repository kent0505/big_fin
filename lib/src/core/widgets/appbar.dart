import 'package:flutter/material.dart';

import '../config/constants.dart';
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
    return AppBar(
      title: child ?? Text(title),
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Button(
          onPressed: Navigator.of(context).pop,
          child: SvgWidget(Assets.back),
        ),
      ),
      actions: [right ?? SizedBox()],
    );
  }
}
