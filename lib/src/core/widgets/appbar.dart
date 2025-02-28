import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/blocs/navbar/navbar_bloc.dart';
import '../config/constants.dart';
import '../config/enums.dart';
import 'button.dart';
import 'svg_widget.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.title,
    this.back = true,
    this.home = false,
    this.onAdd,
  });

  final String title;
  final bool back;
  final bool home;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            SizedBox(width: 16),
            if (back)
              Button(
                onPressed: () {
                  context.pop();
                },
                child: SvgWidget(Assets.back),
              ),
            Expanded(
              child: Text(
                title,
                textAlign: back ? TextAlign.center : null,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: back ? 18 : 24,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ),
            onAdd == null
                ? home
                    ? BlocBuilder<NavbarBloc, NavbarState>(
                        builder: (context, state) {
                          return state is NavbarHome
                              ? Button(
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
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: AppFonts.bold,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      SizedBox(
                                        width: 24,
                                        child: SvgWidget(Assets.bottom),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                )
                              : SizedBox();
                        },
                      )
                    : SizedBox(width: 44)
                : Button(
                    onPressed: onAdd,
                    child: SvgWidget(
                      Assets.add,
                      color: Colors.white,
                      height: 24,
                    ),
                  ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _PeriodDialog extends StatelessWidget {
  const _PeriodDialog();

  @override
  Widget build(BuildContext context) {
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
          color: Color(0xff1B1B1B),
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
    return Button(
      onPressed: () {
        context.read<NavbarBloc>().add(ChangePeriod(period: period));
        context.pop();
      },
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          return state is NavbarHome
              ? Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        getPeriodTitle(period),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                    ),
                    if (period == state.period) SvgWidget(Assets.check),
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
    return Expanded(
      child: Center(
        child: Container(
          height: 0.5,
          color: Color(0xff313131),
        ),
      ),
    );
  }
}
