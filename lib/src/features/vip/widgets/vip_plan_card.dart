import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
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

  String formatMonthlyPrice(
    String priceString,
    bool yearly,
    AppLocalizations l,
  ) {
    String numericPart = priceString.replaceAll(RegExp(r'[^\d,.]'), '');
    double price = double.tryParse(numericPart.replaceAll(',', '.')) ?? 0.0;
    double monthlyPrice = yearly ? (price / 12) : price;
    String currencySymbol =
        priceString.replaceAll(RegExp(r'[\d,.]'), '').trim();
    return '($currencySymbol${monthlyPrice.toStringAsFixed(2)}/${l.mo2})';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
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
            onPressed(product, yearly);
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
                formatMonthlyPrice(
                  product.priceString,
                  yearly,
                  l,
                ),
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                  fontFamily: AppFonts.bold,
                ),
              ),
              if (yearly) ...[
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${l.save} 50%',
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
