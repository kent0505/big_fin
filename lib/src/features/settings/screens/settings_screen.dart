import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../widgets/premium_tile.dart';
import '../widgets/settings_other_options.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            SettingsTile(
              title: 'Transactions',
              asset: Assets.set1,
              onPressed: () {
                context.push(AppRoutes.all);
              },
            ),
            SettingsTile(
              title: 'Budgets',
              asset: Assets.set2,
              onPressed: () {
                context.push(AppRoutes.budget);
              },
            ),
            SettingsTile(
              title: 'Categories',
              asset: Assets.set3,
              onPressed: () {
                context.push(AppRoutes.categories);
              },
            ),
            SettingsTile(
              title: 'Theme',
              asset: Assets.set4,
              onPressed: () {
                context.push(AppRoutes.theme);
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        PremiumTile(),
        SizedBox(height: 16),
        Text(
          'Other options',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: AppFonts.bold,
          ),
        ),
        SettingsOtherOptions(
          title: 'Privacy Policy',
          asset: Assets.set5,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'Terms of Use',
          asset: Assets.set6,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'About Us',
          asset: Assets.set7,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'Download Data',
          asset: Assets.set8,
          vip: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'Import Data',
          asset: Assets.set9,
          vip: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'Write Support',
          asset: Assets.set10,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'VIP functions',
          asset: Assets.set11,
          vipFunc: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: 'Language',
          asset: Assets.set12,
          onPressed: () {},
        ),
      ],
    );
  }
}
