import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/vip.dart';
import '../bloc/bloc/vip_bloc.dart';
import '../data/vip_repository.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  final _currentSubscriptionNotifier = ValueNotifier('');
  final _productDetails = ValueNotifier<ProductDetails?>(null);

  Vip vip = vipsList.last;

  void onPlan(Vip value) {
    setState(() {
      vip = value;
    });
  }

  void onSubscribe() {}

  @override
  void initState() {
    super.initState();
    context.read<VipBloc>().add(LoadVips());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return ValueListenableBuilder<ProductDetails?>(
      valueListenable: _productDetails,
      builder: (context, productDetails, child) {
        return Scaffold(
          body: Stack(
            children: [
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
                    _Feature(title: l.premiumFeature5),
                    ValueListenableBuilder(
                      valueListenable: _currentSubscriptionNotifier,
                      builder: (context, currentSubscription, child) {
                        return BlocBuilder<VipBloc, VipState>(
                          builder: (context, state) {
                            return switch (state) {
                              VipsLoaded subscriptionLoadCompleted => ListBody(
                                  children: subscriptionLoadCompleted
                                      .productDetailList
                                      .map(
                                        (productDetails) => _PlanCard(
                                          productDetails: productDetails,
                                          onPressed: (productDetails) {
                                            _productDetails.value =
                                                productDetails;
                                            _currentSubscriptionNotifier.value =
                                                productDetails.title;
                                          },
                                          currentSubscription:
                                              currentSubscription,
                                        ),
                                      )
                                      .toList(),
                                ),
                              _ => Text('$state'),
                            };
                          },
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
              Positioned(
                right: 16,
                top: MediaQuery.of(context).viewPadding.top,
                child: Button(
                  onPressed: () async {
                    // try {
                    //   final data = await VipRepositoryImpl(
                    //     inAppPurchase: InAppPurchase.instance,
                    //   ).loadProductList();

                    //   for (var e in data) {
                    //     logger(e.price);
                    //     logger(e.title);
                    //     logger(e.description);
                    //   }
                    // } on Object catch (e) {
                    //   logger(e);
                    // }
                    context.pop();
                  },
                  child: SvgWidget(
                    Assets.close,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ButtonWrapper(
                  button: MainButton(
                    title: l.subscribe,
                    onPressed: () {
                      final productDetails = _productDetails.value;
                      if (productDetails != null) {
                        VipRepositoryImpl(
                          inAppPurchase: InAppPurchase.instance,
                        ).buySubscription(productDetails).then((value) {
                          // if (value && context.mounted) {
                          //   context.pop();
                          // }
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.productDetails,
    required this.onPressed,
    required this.currentSubscription,
  });

  final ProductDetails productDetails;
  final String currentSubscription;
  final void Function(ProductDetails productDetails) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
        border: currentSubscription == productDetails.title
            ? Border.all(
                width: 1.5,
                color: colors.accent,
              )
            : null,
      ),
      child: Button(
        onPressed: () {
          onPressed(productDetails);
        },
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentSubscription == productDetails.title
                    ? colors.accent
                    : null,
                border: Border.all(
                  width: 2,
                  color: currentSubscription == productDetails.title
                      ? colors.accent
                      : colors.textSecondary,
                ),
              ),
              child: Center(
                child: SvgWidget(
                  Assets.check,
                  color: currentSubscription == productDetails.title
                      ? colors.bg
                      : Colors.transparent,
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
                    productDetails.title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productDetails.description,
                    maxLines: 1,
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
                  productDetails.price,
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
