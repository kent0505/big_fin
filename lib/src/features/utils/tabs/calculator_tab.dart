import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/calc.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/options_button.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';
import '../bloc/utils_bloc.dart';
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
    final l = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TitleText(l.devicePower),
        const SizedBox(height: 6),
        TxtField(
          controller: powerController,
          hintText: '${l.ex}: 150',
          number: true,
          decimal: false,
          onChanged: (_) {
            checkActive();
          },
        ),
        const SizedBox(height: 12),
        TitleText(l.operatingTime),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TxtField(
                controller: timeController,
                hintText: '${l.ex}: 2',
                number: true,
                decimal: false,
                onChanged: (_) {
                  checkActive();
                },
              ),
            ),
            OptionsButton(
              title: operating == Operating.hours ? l.hours : l.days,
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
        TitleText('${l.tariff} (${getTariffText(tariff)}/kWh)'),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TxtField(
                controller: tariffController,
                hintText: '${l.ex}: 200',
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
          title: l.calculate,
          active: active,
          onPressed: onCalculate,
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            TitleText(l.recentCalculations),
            const Spacer(),
            Button(
              onPressed: () {
                context.push(CalcHistoryScreen.routePath);
              },
              child: Text(
                l.seeAll,
                style: TextStyle(
                  color: colors.accent,
                  fontSize: 14,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<UtilsBloc, UtilsState>(
          builder: (context, state) {
            return state is CalcsLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.calcs.length,
                    itemBuilder: (context, index) {
                      return CalculationCard(
                        calc: state.calcs.reversed.toList()[index],
                      );
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}
