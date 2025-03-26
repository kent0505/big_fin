import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../bloc/bloc/vip_bloc.dart';

class VipPlanCard extends StatelessWidget {
  const VipPlanCard({
    super.key,
    required this.product,
    required this.current,
    required this.onPressed,
  });

  final StoreProduct product;
  final String current;
  final void Function(StoreProduct, bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final state = context.watch<VipBloc>().state;
    final yearly = product.identifier == Identifiers.yearly;

    return Expanded(
      child: Container(
        height: 175,
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(20),
          border: current == product.title
              ? Border.all(
                  width: 2,
                  color: colors.accent,
                )
              : null,
        ),
        child: Button(
          onPressed: () {
            if (state is VipPurchased) {
              showDialog(
                context: context,
                builder: (context) {
                  return InfoDialog(title: 'You already have a subscription');
                },
              );
            } else {
              onPressed(product, yearly);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  fontFamily: AppFonts.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.priceString,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 24,
                  fontFamily: AppFonts.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '(\$${yearly ? (product.price / 12).toStringAsFixed(2) : product.price.toStringAsFixed(2)}/mo)',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  fontFamily: AppFonts.bold,
                ),
              ),
              if (yearly) ...[
                const SizedBox(height: 8),
                Container(
                  height: 24,
                  width: 77,
                  decoration: BoxDecoration(
                    color: colors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Save 50%',
                      style: TextStyle(
                        color: colors.bg,
                        fontSize: 12,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
