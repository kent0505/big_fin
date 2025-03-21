import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/bloc/vip_bloc.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  StoreProduct? product;

  void onPlan(StoreProduct value) {
    setState(() {
      product = value;
    });
  }

  void onSubscribe() async {
    context.read<VipBloc>().add(BuyVip(product: product!));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<VipBloc, VipState>(
        listener: (context, state) {
          if (state is VipError) {
            showDialog(
              context: context,
              builder: (context) {
                return InfoDialog(title: l.error);
              },
            );
          }
        },
        builder: (context, state) {
          if (state is VipLoading) {
            return Center(child: LoadingWidget());
          }

          return Stack(
            children: [
              if (state is VipPurchased)
                Center(
                  child: Text(
                    l.premiumIsActive,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 32,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ),
              if (state is VipsLoaded) ...[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.onb4),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.accent.withValues(alpha: 0),
                        colors.accent.withValues(alpha: 0.4),
                        colors.bg,
                        colors.bg,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 78 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        l.goPremium,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 32,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                      const SizedBox(height: 26),
                      _Feature(title: l.premiumFeature1),
                      _Feature(title: l.premiumFeature2),
                      _Feature(title: l.premiumFeature3),
                      _Feature(title: l.premiumFeature4),
                      const SizedBox(height: 50),
                      ...List.generate(
                        state.products.length,
                        (index) {
                          return _PlanCard(
                            product: state.products[index],
                            current: product?.title ?? '',
                            onPressed: onPlan,
                          );
                        },
                      ),

                      // const SizedBox(height: 8),
                      // Text(
                      //   'Automatically renews for \$200.00 / month until canceled.',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: colors.textPrimary,
                      //     fontSize: 12,
                      //     fontFamily: AppFonts.medium,
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
              Positioned(
                right: 16,
                top: MediaQuery.of(context).viewPadding.top,
                child: Button(
                  onPressed: () {
                    context.pop();
                  },
                  child: SvgWidget(
                    Assets.close,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              if (state is VipsLoaded)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonWrapper(
                    button: MainButton(
                      title: l.subscribe,
                      active: product != null,
                      onPressed: onSubscribe,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
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

class _Feature extends StatelessWidget {
  const _Feature({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgWidget(
            Assets.check,
            color: colors.textPrimary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontFamily: AppFonts.bold,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
