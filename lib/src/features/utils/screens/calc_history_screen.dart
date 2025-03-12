import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/utils_bloc.dart';
import '../widgets/calculation_card.dart';

class CalcHistoryScreen extends StatelessWidget {
  const CalcHistoryScreen({super.key});

  static const routePath = '/CalcHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'Calculation History',
        right: BlocBuilder<UtilsBloc, UtilsState>(
          builder: (context, state) {
            return state is CalcsLoaded && state.calcs.isNotEmpty
                ? Button(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWidget(
                            title: 'Clear all?',
                            description:
                                'You won’t be able to undo this action.',
                            leftTitle: 'Delete',
                            rightTitle: 'Cancel',
                            onYes: () {
                              context
                                  .read<UtilsBloc>()
                                  .add(DeleteCalcResults());
                              context.pop();
                            },
                          );
                        },
                      );
                    },
                    child: SvgWidget(Assets.delete),
                  )
                : const SizedBox();
          },
        ),
      ),
      body: BlocBuilder<UtilsBloc, UtilsState>(
        builder: (context, state) {
          return state is CalcsLoaded
              ? state.calcs.isEmpty
                  ? Center(
                      child: NoData(
                        title: 'No calculations yet',
                        description: '',
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: state.calcs.reversed.toList().length,
                      itemBuilder: (context, index) {
                        return CalculationCard(
                          calc: state.calcs.reversed.toList()[index],
                        );
                      },
                    )
              : const SizedBox();
        },
      ),
    );
  }
}
