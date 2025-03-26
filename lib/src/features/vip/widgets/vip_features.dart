import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/svg_widget.dart';
import 'vip_timer.dart';

class VipFeatures extends StatelessWidget {
  const VipFeatures({super.key, required this.timer});

  final bool timer;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        if (timer) ...[
          const SizedBox(height: 16),
          VipTimer(),
          const SizedBox(height: 16),
          if (isIOS())
            const VipFeature(
              title:
                  'Artificial Intelligence Without Limits — Assistance 24/7.',
            ),
          const VipFeature(
            title: 'Data Export and Import — Easy Data Handling.',
          ),
          const VipFeature(
            title: 'Advanced Analytics — Insights for Decision-Making.',
          ),
          const VipFeature(
            title: 'Image attachment to transcations',
          ),
        ] else ...[
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Choose a plan',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Free',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isIOS())
            const VipFeature(
              title: 'Artificial Intelligence Without Limits',
              timer: false,
            ),
          const VipFeature(
            title: 'Data Export and Import',
            timer: false,
          ),
          const VipFeature(
            title: 'Advanced Analytics',
            timer: false,
          ),
          const VipFeature(
            title: 'Image attachment to transcations',
            timer: false,
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

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
