import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../vip/screens/vip_screen.dart';

class PremiumTile extends StatelessWidget {
  const PremiumTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          VipSheet.show(context);
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            const SizedBox(
              height: 32,
              child: SvgWidget(Assets.diamond),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    l.premiumTitle,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.premiumDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              child: SvgWidget(
                Assets.right,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
