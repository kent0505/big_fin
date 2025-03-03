import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/my_colors.dart';
import '../bloc/home_bloc.dart';
import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
    this.right,
  });

  final Widget? right;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          title: Text(
            state is HomeInitial
                ? 'Home'
                : state is HomeAnalytics
                    ? 'Analytics'
                    : state is HomeAssistant
                        ? 'AI Assistant'
                        : state is HomeUtilities
                            ? 'Utilities'
                            : 'Settings',
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 24,
              fontFamily: AppFonts.bold,
            ),
          ),
          centerTitle: false,
          actions: [
            if (state is HomeInitial)
              Button(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _PeriodDialog();
                    },
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      getPeriodTitle(state.period),
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 14,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 24,
                      child: SvgWidget(
                        Assets.bottom,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              )
          ],
        );
      },
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
        height: 180,
        width: 220,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(
          top: 60 + MediaQuery.of(context).viewPadding.top,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _PeriodButton(period: Period.monthly),
            _Divider(),
            _PeriodButton(period: Period.weekly),
            _Divider(),
            _PeriodButton(period: Period.daily),
          ],
        ),
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({required this.period});

  final Period period;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: () {
        context.read<HomeBloc>().add(ChangePeriod(period: period));
        context.pop();
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state is HomeInitial
              ? Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        getPeriodTitle(period),
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
                    SizedBox(width: 16),
                  ],
                )
              : SizedBox();
        },
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Center(
        child: Container(
          height: 0.5,
          color: colors.tertiaryFour,
        ),
      ),
    );
  }
}
