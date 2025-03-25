import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/bloc/vip_bloc.dart';
import '../widgets/vip_feature.dart';
import '../widgets/vip_plan_card.dart';

class VipSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return VipScreen();
      },
    );
  }
}

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

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

    return BlocConsumer<VipBloc, VipState>(
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
                    VipFeature(title: l.premiumFeature1),
                    VipFeature(title: l.premiumFeature2),
                    VipFeature(title: l.premiumFeature3),
                    VipFeature(title: l.premiumFeature4),
                    const SizedBox(height: 26),
                    ...List.generate(
                      state.products.length,
                      (index) {
                        return VipPlanCard(
                          product: state.products[index],
                          current: product?.title ?? '',
                          onPressed: onPlan,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],

            // КНОПКА ЗАКРЫТИЯ
            Positioned(
              right: 16,
              top: 50,
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
                  transparent: true,
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
    );
  }
}
