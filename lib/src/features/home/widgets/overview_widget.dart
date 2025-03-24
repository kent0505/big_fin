import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/date_pick.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/home_bloc.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Text(
            l.overview,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
        Button(
          onPressed: () {
            showDialog<DateTime>(
              context: context,
              builder: (context) {
                return DatePick(date: date);
              },
            ).then((value) {
              if (value != null && context.mounted) {
                context.read<HomeBloc>().add(SortByDate(date: value));
              }
            });
          },
          child: SvgWidget(
            Assets.calendar,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
