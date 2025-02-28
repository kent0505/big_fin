import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class PremiumTile extends StatelessWidget {
  const PremiumTile({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 100,
        child: Button(
          onPressed: () {
            context.push(AppRoutes.vip);
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
                    Text(
                      'Unlock Premium Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage your finances wisely and begin saving now!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppFonts.medium,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              SvgWidget(Assets.right),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
