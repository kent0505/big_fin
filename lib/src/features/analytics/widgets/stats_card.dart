import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../settings/data/settings_repository.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.transactions,
    required this.expensePerDay,
    required this.expensePerTransaction,
    required this.incomePerDay,
    required this.incomePerTransaction,
  });

  final int transactions;
  final double expensePerDay;
  final double expensePerTransaction;
  final double incomePerDay;
  final double incomePerTransaction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final currency = context.read<SettingsRepository>().getCurrency();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _Title(
            title: l.numberOfTransactions,
            data: transactions.toString(),
          ),
          SizedBox(height: 8),
          _Title(
            title: l.expensePerDay,
            data: '$currency${expensePerDay.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: l.expensePerTransaction,
            data: '$currency${expensePerTransaction.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: l.incomePerDay,
            data: '$currency${incomePerDay.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: l.incomePerTransaction,
            data: '$currency${incomePerTransaction.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
        ),
        Text(
          data,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 14,
            fontFamily: AppFonts.medium,
          ),
        ),
      ],
    );
  }
}
