import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../budget/screens/budget_screen.dart';
import '../../category/screens/categories_screen.dart';
import '../../expense/screens/all_transactions_screen.dart';
import '../../theme/screens/theme_screen.dart';
import '../widgets/premium_tile.dart';
import '../widgets/settings_other_options.dart';
import '../widgets/settings_tile.dart';
import '../../language/screens/language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context);

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            SettingsTile(
              title: l.transactions,
              asset: Assets.set1,
              onPressed: () {
                context.push(AllTransactionsScreen.routePath);
              },
            ),
            SettingsTile(
              title: l.budgets,
              asset: Assets.set2,
              onPressed: () {
                context.push(BudgetScreen.routePath);
              },
            ),
            SettingsTile(
              title: l.categories,
              asset: Assets.set3,
              onPressed: () {
                context.push(CategoriesScreen.routePath);
              },
            ),
            SettingsTile(
              title: l.theme,
              asset: Assets.set4,
              onPressed: () {
                context.push(ThemeScreen.routePath);
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        PremiumTile(),
        SizedBox(height: 16),
        Text(
          l.otherOptions,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 14,
            fontFamily: AppFonts.bold,
          ),
        ),
        SettingsOtherOptions(
          title: l.privacyPolicy,
          asset: Assets.set5,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.termsOfUse,
          asset: Assets.set6,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.aboutUs,
          asset: Assets.set7,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.downloadData,
          asset: Assets.set8,
          vip: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.importData,
          asset: Assets.set9,
          vip: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.writeSupport,
          asset: Assets.set10,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.vipFunctions,
          asset: Assets.set11,
          vipFunc: true,
          onPressed: () {},
        ),
        SettingsOtherOptions(
          title: l.language,
          asset: Assets.set12,
          onPressed: () {
            context.push(LanguageScreen.routePath);
          },
        ),
      ],
    );
  }
}
