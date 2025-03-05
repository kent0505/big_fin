import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/tab_widget.dart';
import '../bloc/utils_bloc.dart';
import 'calculator_screen.dart';

class UtilitiesScreen extends StatelessWidget {
  const UtilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        BlocBuilder<UtilsBloc, UtilsState>(
          builder: (context, state) {
            return TabWidget(
              tabs: [
                TabItem(
                  title: 'Calculator',
                  active: state is UtilsInitial,
                  onPressed: () {
                    context.read<UtilsBloc>().add(ChangeUtils(id: 1));
                  },
                ),
                TabItem(
                  title: 'Comparison',
                  active: state is UtilsComparison,
                  onPressed: () {
                    context.read<UtilsBloc>().add(ChangeUtils(id: 2));
                  },
                ),
                TabItem(
                  title: 'News',
                  active: state is UtilsNews,
                  onPressed: () {
                    context.read<UtilsBloc>().add(ChangeUtils(id: 3));
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<UtilsBloc, UtilsState>(
            builder: (context, state) {
              if (state is UtilsInitial) return CalculatorScreen();

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [],
              );
            },
          ),
        ),
      ],
    );
  }
}
