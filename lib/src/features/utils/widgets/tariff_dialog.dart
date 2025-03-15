import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/my_divider.dart';
import '../../../core/widgets/svg_widget.dart';

class TariffDialog extends StatelessWidget {
  const TariffDialog({super.key, required this.current});

  final Tariff current;

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
            _Button(
              tariff: Tariff.usd,
              current: current,
            ),
            MyDivider(),
            _Button(
              tariff: Tariff.eur,
              current: current,
            ),
            MyDivider(),
            _Button(
              tariff: Tariff.gbp,
              current: current,
            ),
            MyDivider(),
            _Button(
              tariff: Tariff.rub,
              current: current,
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.tariff,
    required this.current,
  });

  final Tariff tariff;
  final Tariff current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: () {
        context.pop(tariff);
      },
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              getTariffText(tariff),
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontFamily: AppFonts.bold,
              ),
            ),
          ),
          if (tariff == current)
            SvgWidget(
              Assets.check,
              color: colors.accent,
            ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
