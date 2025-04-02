import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/sheet_widget.dart';
import '../bloc/bloc/vip_bloc.dart';
import '../widgets/stars_widget.dart';
import '../widgets/vip_features.dart';
import '../widgets/vip_plan_card.dart';
import '../widgets/vip_purchased_widget.dart';
import '../widgets/vip_questions.dart';

class VipSheet {
  static void show(BuildContext context, {bool timer = false}) {
    if (isIOS()) {
      showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return VipScreen(timer: timer);
        },
      );
    }
  }
}

class VipScreen extends StatefulWidget {
  const VipScreen({super.key, required this.timer});

  final bool timer;

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  StoreProduct? product;
  bool yearly = false;
  bool close = false;

  void onPlan(StoreProduct value, bool isYear) {
    if (product != null && product!.price == value.price) return;
    setState(() {
      product = value;
      yearly = isYear;
    });
  }

  void onSubscribe() async {
    context.read<VipBloc>().add(BuyVip(product: product!));
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        close = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return SheetWidget(
      close: close,
      child: BlocConsumer<VipBloc, VipState>(
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
            return const Center(
              child: LoadingWidget(),
            );
          }

          if (state is VipPurchased) {
            return const VipPurchasedWidget();
          }

          if (state is VipsLoaded) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 100),
                StarsWidget(title: l.appleAppDay),
                VipFeatures(timer: widget.timer),
                Row(
                  spacing: 8,
                  children: List.generate(
                    state.products.length,
                    (index) {
                      return VipPlanCard(
                        product: state.products[index],
                        current: product?.title ?? '',
                        onPressed: onPlan,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (product != null) ...[
                  Text(
                    l.renews(
                      product!.price.toStringAsFixed(2),
                      yearly ? l.mo3 : l.mo1,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 12,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
                if (widget.timer) VipQuestions(),
                const SizedBox(height: 36),
                if (state.products.isNotEmpty) ...[
                  MainButton(
                    title: widget.timer ? l.unlockFeatures : l.upgradePro,
                    active: product != null,
                    onPressed: onSubscribe,
                  ),
                  const SizedBox(height: 44),
                ],
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
