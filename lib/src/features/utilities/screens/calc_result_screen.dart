import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/calc.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/title_text.dart';

class CalcResultScreen extends StatefulWidget {
  const CalcResultScreen({super.key, required this.calc});

  final Calc calc;

  static const routePath = '/CalcResultScreen';

  @override
  State<CalcResultScreen> createState() => _CalcResultScreenState();
}

class _CalcResultScreenState extends State<CalcResultScreen> {
  double energy = 0;
  double cost = 0;

  double calculateEnergyConsumption(
    double powerW,
    double operatingTime,
    bool isDays,
  ) {
    double operatingHours = isDays ? operatingTime * 24 : operatingTime;
    return (powerW * operatingHours) / 1000;
  }

  double calculateElectricityCost(double energyConsumption, double tariff) {
    return energyConsumption * tariff;
  }

  @override
  void initState() {
    super.initState();
    energy = calculateEnergyConsumption(
      widget.calc.devicePower,
      widget.calc.operatingTime,
      widget.calc.operating == Operating.days,
    );
    cost = calculateElectricityCost(
      energy,
      widget.calc.tariffAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(title: 'Calculation Result'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TitleText('Total Energy Consumption (kWh)'),
                const SizedBox(height: 6),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors.tertiaryOne,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        energy.toStringAsFixed(2),
                        style: TextStyle(
                          color: colors.accent,
                          fontSize: 16,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TitleText(
                  'Cost of Consumed Electricity (${getTariffText(widget.calc.tariff)})',
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: colors.tertiaryOne,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              cost.toStringAsFixed(2),
                              style: TextStyle(
                                color: colors.accent,
                                fontSize: 16,
                                fontFamily: AppFonts.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getTariffText(widget.calc.tariff),
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 14,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgWidget(
                      Assets.bottom,
                      color: colors.textPrimary,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: 'Save to Calculation History',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
