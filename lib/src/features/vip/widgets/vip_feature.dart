import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/svg_widget.dart';

class VipFeature extends StatelessWidget {
  const VipFeature({
    super.key,
    required this.title,
    this.timer = true,
  });

  final String title;
  final bool timer;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return timer
        ? Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                SvgWidget(
                  Assets.check,
                  color: colors.accent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontFamily: AppFonts.bold,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 56,
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: colors.textPrimary,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ),
                SizedBox(
                  width: 132,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgWidget(
                        Assets.close,
                        color: colors.system,
                      ),
                      SvgWidget(
                        Assets.check,
                        color: colors.accent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
