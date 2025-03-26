import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import 'vip_features.dart';

class VipPurchasedWidget extends StatelessWidget {
  const VipPurchasedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    // final l = AppLocalizations.of(context)!;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 100),
        Center(
          child: Text(
            'Welcome to premium version',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 32,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
        const SizedBox(height: 64),
        Image.asset(
          Assets.premium,
          height: 150,
        ),
        const SizedBox(height: 64),
        if (isIOS())
          const VipFeature(
            title: 'Artificial Intelligence Without Limits — Assistance 24/7.',
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
      ],
    );
  }
}
