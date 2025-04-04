import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/my_divider.dart';
import '../../../core/widgets/options_button.dart';
import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../bloc/home_bloc.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, this.right});

  final Widget? right;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return AppBar(
      title: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Text(
            state is HomeInitial
                ? l.home
                : state is HomeAnalytics
                    ? l.analytics
                    : state is HomeAssistant
                        ? l.assistant
                        : state is HomeUtilities
                            ? l.utilities
                            : l.settings,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 24,
              fontFamily: AppFonts.bold,
            ),
          );
        },
      ),
      centerTitle: false,
      actions: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state is HomeInitial
                ? BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      return state is ExpensesLoaded
                          ? OptionsButton(
                              title: state.period == Period.daily
                                  ? l.daily
                                  : state.period == Period.weekly
                                      ? l.weekly
                                      : l.monthly,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const _PeriodDialog();
                                  },
                                );
                              },
                            )
                          : const SizedBox();
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

class _PeriodDialog extends StatelessWidget {
  const _PeriodDialog();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(
          top: 60 + MediaQuery.of(context).viewPadding.top,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Button(period: Period.monthly),
            MyDivider(),
            _Button(period: Period.weekly),
            MyDivider(),
            _Button(period: Period.daily),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.period});

  final Period period;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Button(
      onPressed: () {
        context.read<ExpenseBloc>().add(ChangePeriod(period: period));
        context.pop();
      },
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          return state is ExpensesLoaded
              ? Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        period == Period.daily
                            ? l.daily
                            : period == Period.weekly
                                ? l.weekly
                                : l.monthly,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                    ),
                    if (period == state.period)
                      SvgWidget(
                        Assets.check,
                        color: colors.accent,
                      ),
                    const SizedBox(width: 16),
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }
}
