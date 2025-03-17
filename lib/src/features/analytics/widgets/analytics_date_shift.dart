import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/date_pick.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../language/bloc/language_bloc.dart';
import '../bloc/analytics_bloc.dart';

class AnalyticsDateShift extends StatelessWidget {
  const AnalyticsDateShift({
    super.key,
    required this.index,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.onShift1,
    required this.onShift2,
  });

  final int index;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final VoidCallback onShift1;
  final VoidCallback onShift2;

  String _formatDate(int index, String locale) {
    switch (index) {
      case 0:
        return '${DateFormat('d MMM', locale).format(startDate)} - ${DateFormat('d MMM', locale).format(endDate)}';
      case 1:
        return DateFormat('MMMM yyyy', locale).format(selectedDate);
      case 2:
        return DateFormat('yyyy').format(selectedDate);
      case 3:
        return DateFormat('d MMM, yyyy', locale).format(selectedDate);
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final locale = context.watch<LanguageBloc>().state.languageCode;

    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        final custom = state is AnalyticsCustom &&
            state.date1.year != 1 &&
            state.date2.year != 1;

        return Row(
          children: [
            SizedBox(width: 16),
            Button(
              onPressed: onShift1,
              child: SvgWidget(
                Assets.back,
                color: colors.textPrimary,
              ),
            ),
            Expanded(
              child: Button(
                onPressed: index == 3
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DatePick(
                              date: selectedDate,
                              range: true,
                            );
                          },
                        );
                      }
                    : null,
                child: Text(
                  custom && index == 3
                      ? '${DateFormat('d MMM yyyy', locale).format(state.date1)} - ${DateFormat('d MMM yyyy', locale).format(state.date2)}'
                      : _formatDate(index, locale),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                    fontFamily: AppFonts.medium,
                  ),
                ),
              ),
            ),
            Button(
              onPressed: onShift2,
              child: SvgWidget(
                Assets.right,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(width: 16),
          ],
        );
      },
    );
  }
}
