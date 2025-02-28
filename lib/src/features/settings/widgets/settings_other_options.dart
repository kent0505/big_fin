import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class SettingsOtherOptions extends StatelessWidget {
  const SettingsOtherOptions({
    super.key,
    required this.title,
    required this.asset,
    this.vip = false,
    this.vipFunc = false,
    required this.onPressed,
  });

  final String title;
  final String asset;
  final bool vip;
  final bool vipFunc;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xff1B1B1B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 56,
          child: Button(
            onPressed: onPressed,
            child: Row(
              children: [
                SizedBox(width: 16),
                SizedBox(
                  width: 24,
                  child: SvgWidget(asset),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: vipFunc ? AppColors.main : Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ),
                if (vip) ...[
                  Text(
                    'VIP',
                    style: TextStyle(
                      color: AppColors.main,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    height: 18,
                    child: SvgWidget(
                      Assets.diamond,
                      height: 18,
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
