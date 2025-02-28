import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.asset,
    required this.onPressed,
  });

  final String title;
  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 56,
        width: (MediaQuery.of(context).size.width - 40) / 2,
        child: Button(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                child: SvgWidget(asset),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
