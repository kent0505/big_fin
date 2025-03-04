import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      child: SizedBox(
        // height: 100,
        child: Button(
          onPressed: () {
            context.push(VipScreen.routePath);
          },
          child: Row(
            children: [
              SizedBox(width: 16),
              SizedBox(
                height: 32,
                child: SvgWidget(Assets.diamond),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      l.premiumTitle,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    SizedBox(height: 4),
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
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(width: 8),
              SvgWidget(
                Assets.right,
                color: colors.textPrimary,
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
