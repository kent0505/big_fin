import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/my_divider.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/utils_bloc.dart';

class TariffDialog extends StatelessWidget {
  const TariffDialog({super.key});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Button(tariff: Tariff.usd),
            MyDivider(),
            _Button(tariff: Tariff.eur),
            MyDivider(),
            _Button(tariff: Tariff.gbp),
            MyDivider(),
            _Button(tariff: Tariff.rub),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.tariff});

  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: () {
        context.read<UtilsBloc>().add(SelectTariff(tariff: tariff));
        context.pop();
      },
      child: BlocBuilder<UtilsBloc, UtilsState>(
        builder: (context, state) {
          return state is UtilsInitial
              ? Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        tariff == Tariff.usd
                            ? 'USD'
                            : tariff == Tariff.eur
                                ? 'EUR'
                                : tariff == Tariff.gbp
                                    ? 'GBP'
                                    : 'RUB',
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                    ),
                    if (tariff == state.tariff)
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
