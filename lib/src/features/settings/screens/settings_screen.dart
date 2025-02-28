import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Appbar(title: 'Settings', back: false),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SettingsTile(
                    title: 'Transactions',
                    asset: Assets.set1,
                    onPressed: () {},
                  ),
                  _SettingsTile(
                    title: 'Budgets',
                    asset: Assets.set2,
                    onPressed: () {
                      context.push(AppRoutes.budget);
                    },
                  ),
                  _SettingsTile(
                    title: 'Categories',
                    asset: Assets.set3,
                    onPressed: () {
                      context.push(AppRoutes.category);
                    },
                  ),
                  _SettingsTile(
                    title: 'Theme',
                    asset: Assets.set4,
                    onPressed: () {
                      context.push(AppRoutes.theme);
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              _PremiumTile(),
              SizedBox(height: 16),
              Text(
                'Other options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: AppFonts.bold,
                ),
              ),
              _OtherOption(
                title: 'Privacy Policy',
                asset: Assets.set5,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'Terms of Use',
                asset: Assets.set6,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'About Us',
                asset: Assets.set7,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'Download Data',
                asset: Assets.set8,
                vip: true,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'Import Data',
                asset: Assets.set9,
                vip: true,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'Write Support',
                asset: Assets.set10,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'VIP functions',
                asset: Assets.set11,
                vipFunc: true,
                onPressed: () {},
              ),
              _OtherOption(
                title: 'Language',
                asset: Assets.set12,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
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
              SvgWidget(asset),
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

class _PremiumTile extends StatelessWidget {
  const _PremiumTile();

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
              SvgWidget(Assets.diamond),
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

class _OtherOption extends StatelessWidget {
  const _OtherOption({
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
                SvgWidget(asset),
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
                  SvgWidget(
                    Assets.diamond,
                    height: 18,
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
