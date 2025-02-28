import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'button.dart';
import 'svg_widget.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    required this.title,
    this.right,
  });

  final String title;
  final Widget? right;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Button(
          onPressed: Navigator.of(context).pop,
          child: SvgWidget(Assets.back),
        ),
      ),
      actions: [
        right ?? SizedBox(),
      ],
    );
  }
}
