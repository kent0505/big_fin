import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/svg_widget.dart';
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
  final void Function(StoreProduct) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final state = context.watch<VipBloc>().state;

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
        border: current == product.title
            ? Border.all(
                width: 1.5,
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
            onPressed(product);
          }
        },
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == product.title ? colors.accent : null,
                border: Border.all(
                  width: 2,
                  color: current == product.title
                      ? colors.accent
                      : colors.textSecondary,
                ),
              ),
              child: Center(
                child: SvgWidget(
                  Assets.check,
                  color:
                      current == product.title ? colors.bg : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.priceString,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
