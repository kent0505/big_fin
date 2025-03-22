import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class SettingsOtherOptions extends StatelessWidget {
  const SettingsOtherOptions({
    super.key,
    required this.title,
    required this.asset,
    this.vip = false,
    this.icon = false,
    required this.onPressed,
  });

  final String title;
  final String asset;
  final bool vip;
  final bool icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 56,
          child: Button(
            onPressed: onPressed,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  height: 24,
                  width: 24,
                  decoration: icon
                      ? BoxDecoration(
                          color: colors.accent,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : null,
                  child: Center(
                    child: SvgWidget(
                      asset,
                      color: icon ? Colors.black : colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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
                if (vip) ...[
                  Text(
                    'VIP',
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const SizedBox(
                    height: 18,
                    child: SvgWidget(
                      Assets.diamond,
                      height: 18,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
