import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/title_text.dart';
import '../../budget/bloc/budget_bloc.dart';
import '../../budget/screens/budget_screen.dart';
import '../../category/bloc/category_bloc.dart';
import '../../category/screens/categories_screen.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../expense/screens/all_transactions_screen.dart';
import '../../theme/screens/theme_screen.dart';
import '../../utils/bloc/utils_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/premium_tile.dart';
import '../widgets/settings_other_options.dart';
import '../widgets/settings_tile.dart';
import '../../language/screens/language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
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
        const SizedBox(height: 8),
        const PremiumTile(),
        const SizedBox(height: 16),
        TitleText(l.otherOptions),
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
          onPressed: () {
            context.read<SettingsBloc>().add(DownloadData());
          },
        ),
        SettingsOtherOptions(
          title: l.importData,
          asset: Assets.set9,
          vip: true,
          onPressed: () {
            context.read<SettingsBloc>().add(ImportData());
            // context.read<ExpenseBloc>().add(GetExpenses());
            // context.read<CategoryBloc>().add(GetCategories());
            // context.read<BudgetBloc>().add(GetBudgets());
            // context.read<UtilsBloc>().add(GetCalcResults());
          },
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
