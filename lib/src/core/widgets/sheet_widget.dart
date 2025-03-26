import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class SheetWidget extends StatelessWidget {
  const SheetWidget({
    super.key,
    required this.child,
    this.close = true,
  });

  final Widget child;
  final bool close;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          child,
          Positioned(
            right: 16,
            top: 50,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: close ? 1 : 0,
              child: Button(
                onPressed: close
                    ? () {
                        context.pop();
                      }
                    : null,
                child: SvgWidget(
                  Assets.close,
                  color: colors.textPrimary.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
