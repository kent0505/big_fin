import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.minSize = kMinInteractiveDimensionCupertino,
    required this.child,
  });

  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double minSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: AppFonts.bold,
            color: colors.textPrimary,
          ),
        ),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: padding,
        minSize: minSize,
        child: child,
      ),
    );
  }
}
