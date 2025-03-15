import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/title_text.dart';
import '../bloc/utils_bloc.dart';
import '../screens/compare_screen.dart';
import '../widgets/calculation_card.dart';

class ComparisonTab extends StatelessWidget {
  const ComparisonTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          height: 222,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.bg,
                colors.linear2,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<UtilsBloc, UtilsState>(
                  builder: (context, state) {
                    if (state is CalcsLoaded) {
                      double energy1 = double.parse(state.selected1.energy);
                      double energy2 = double.parse(state.selected2.energy);
                      double cost1 = double.parse(state.selected1.cost);
                      double cost2 = double.parse(state.selected2.cost);

                      double efficiency1 = cost1 != 0 ? (energy1 / cost1) : 0;
                      double efficiency2 = cost2 != 0 ? (energy2 / cost2) : 0;

                      double minValue = [
                        energy1,
                        energy2,
                        cost1,
                        cost2,
                        efficiency1,
                        efficiency2,
                      ].reduce((a, b) => a < b ? a : b);
                      double maxValue = [
                        energy1,
                        energy2,
                        cost1,
                        cost2,
                        efficiency1,
                        efficiency2,
                      ].reduce((a, b) => a > b ? a : b);

                      double normalize(double value) {
                        if (maxValue == minValue) return 20;
                        return ((value - minValue) / (maxValue - minValue)) *
                                (170 - 20) +
                            20;
                      }

                      double normalizedEnergy1 = normalize(energy1);
                      double normalizedEnergy2 = normalize(energy2);
                      double normalizedCost1 = normalize(cost1);
                      double normalizedCost2 = normalize(cost2);
                      double normalizedEfficiency1 = normalize(efficiency1);
                      double normalizedEfficiency2 = normalize(efficiency2);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _BarChart(
                            value1: energy1,
                            value2: normalizedEnergy1,
                          ),
                          SizedBox(width: 8),
                          _BarChart(
                            value1: energy2,
                            value2: normalizedEnergy2,
                            second: true,
                          ),
                          SizedBox(width: 16),
                          _BarChart(
                            value1: cost1,
                            value2: normalizedCost1,
                          ),
                          SizedBox(width: 8),
                          _BarChart(
                            value1: cost2,
                            value2: normalizedCost2,
                            second: true,
                          ),
                          SizedBox(width: 16),
                          _BarChart(
                            value1: efficiency1,
                            value2: normalizedEfficiency1,
                          ),
                          SizedBox(width: 8),
                          _BarChart(
                            value1: efficiency2,
                            value2: normalizedEfficiency2,
                            second: true,
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _ChartTitle('Energy Consumption'),
                  _ChartTitle('Operating Cost'),
                  _ChartTitle('Efficiency'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.accent,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'First result',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 10,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.violet,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Second result',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 10,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: TitleText('Recent calculations'),
            ),
            Button(
              onPressed: () {
                context.push(CompareScreen.routePath);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Compare other',
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
        SizedBox(height: 8),
        BlocBuilder<UtilsBloc, UtilsState>(
          builder: (context, state) {
            return state is CalcsLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.calcs.length,
                    itemBuilder: (context, index) {
                      final calc = state.calcs.reversed.toList()[index];

                      return CalculationCard(
                        calc: calc,
                        selected1: calc.id == state.selected1.id,
                        selected2: calc.id == state.selected2.id,
                        onPressed: () {
                          context
                              .read<UtilsBloc>()
                              .add(SelectCalcResult(calc: calc));
                        },
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

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.value1,
    required this.value2,
    this.second = false,
  });

  final double value1;
  final double value2;
  final bool second;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: value2,
      width: 45,
      decoration: BoxDecoration(
        color: second ? colors.violet : colors.accent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
          bottom: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Text(
            value1.toStringAsFixed(2),
            style: TextStyle(
              color: colors.tertiaryOne,
              fontSize: 8,
              fontFamily: AppFonts.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartTitle extends StatelessWidget {
  const _ChartTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 8,
          fontFamily: AppFonts.medium,
        ),
      ),
    );
  }
}
