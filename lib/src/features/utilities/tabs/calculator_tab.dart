import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/calc.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/options_button.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';
import '../widgets/calculation_card.dart';
import '../widgets/operating_dialog.dart';
import '../widgets/tariff_dialog.dart';
import '../screens/calc_history_screen.dart';
import '../screens/calc_result_screen.dart';

class CalculatorTab extends StatefulWidget {
  const CalculatorTab({super.key});

  @override
  State<CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  final powerController = TextEditingController();
  final timeController = TextEditingController();
  final tariffController = TextEditingController();

  bool active = false;

  Operating operating = Operating.hours;
  Tariff tariff = Tariff.usd;

  void checkActive() {
    setState(() {
      active = [
        powerController,
        timeController,
        tariffController,
      ].every((element) => element.text.isNotEmpty);
    });
  }

  void onCalculate() {
    context.push(
      CalcResultScreen.routePath,
      extra: Calc(
        devicePower: double.tryParse(powerController.text) ?? 0,
        operatingTime: double.tryParse(timeController.text) ?? 0,
        tariffAmount: double.tryParse(tariffController.text) ?? 0,
        operating: operating,
        tariff: tariff,
      ),
    );
  }

  @override
  void dispose() {
    powerController.dispose();
    timeController.dispose();
    tariffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const TitleText('Device Power (W)'),
        const SizedBox(height: 6),
        TxtField(
          controller: powerController,
          hintText: 'Ex: 150',
          number: true,
          decimal: false,
          onChanged: (_) {
            checkActive();
          },
        ),
        const SizedBox(height: 12),
        const TitleText('Operating Time'),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TxtField(
                controller: timeController,
                hintText: 'Ex: 2',
                number: true,
                decimal: false,
                onChanged: (_) {
                  checkActive();
                },
              ),
            ),
            OptionsButton(
              title: operating == Operating.hours ? 'Hours' : 'Days',
              onPressed: () async {
                operating = await showDialog<Operating>(
                  context: context,
                  builder: (context) {
                    return OperatingDialog(current: operating);
                  },
                ).then((value) {
                  operating = value ?? operating;
                  setState(() {});
                  return operating;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        TitleText('Tariff (${getTariffText(tariff)}/kWh)'),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TxtField(
                controller: tariffController,
                hintText: 'Ex: 200',
                number: true,
                onChanged: (_) {
                  checkActive();
                },
              ),
            ),
            OptionsButton(
              title: getTariffSign(tariff),
              onPressed: () async {
                tariff = await showDialog<Tariff>(
                  context: context,
                  builder: (context) {
                    return TariffDialog(current: tariff);
                  },
                ).then((value) {
                  tariff = value ?? tariff;
                  setState(() {});
                  return tariff;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        MainButton(
          title: 'Calculate',
          active: active,
          onPressed: onCalculate,
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            const TitleText('Recent calculations'),
            const Spacer(),
            SizedBox(
              width: 66,
              child: Button(
                onPressed: () {
                  context.push(CalcHistoryScreen.routePath);
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 14,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const CalculationCard(),
      ],
    );
  }
}
