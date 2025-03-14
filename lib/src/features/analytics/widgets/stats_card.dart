import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

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

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _Title(
            title: 'Number of transactions',
            data: transactions.toString(),
          ),
          SizedBox(height: 8),
          _Title(
            title: 'Average expense per day',
            data: '\$${expensePerDay.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: 'Average expense per transaction',
            data: '\$${expensePerTransaction.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: 'Average income per day',
            data: '\$${incomePerDay.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8),
          _Title(
            title: 'Average income per transaction',
            data: '\$${incomePerTransaction.toStringAsFixed(2)}',
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
