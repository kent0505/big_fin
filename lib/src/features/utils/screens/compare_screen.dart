import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';
import '../bloc/utils_bloc.dart';
import '../widgets/calculation_card.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  static const routePath = '/CompareScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Compare other'),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<UtilsBloc, UtilsState>(
              builder: (context, state) {
                return state is CalcsLoaded
                    ? ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: state.calcs.length,
                        itemBuilder: (context, index) {
                          return CalculationCard(
                            calc: state.calcs.reversed.toList()[index],
                            selected1:
                                state.calcs.reversed.toList()[index].id ==
                                    state.selected1.id,
                            selected2:
                                state.calcs.reversed.toList()[index].id ==
                                    state.selected2.id,
                            onPressed: () {
                              context.read<UtilsBloc>().add(
                                    SelectCalcResult(
                                      calc:
                                          state.calcs.reversed.toList()[index],
                                    ),
                                  );
                            },
                          );
                        },
                      )
                    : const SizedBox();
              },
            ),
          ),
          BlocBuilder<UtilsBloc, UtilsState>(
            builder: (context, state) {
              return state is CalcsLoaded
                  ? ButtonWrapper(
                      button: MainButton(
                        title: 'Compare',
                        active:
                            state.selected1.id != 0 && state.selected2.id != 0,
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
