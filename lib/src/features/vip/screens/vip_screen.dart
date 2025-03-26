import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/sheet_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/bloc/vip_bloc.dart';
import '../widgets/vip_feature.dart';
import '../widgets/vip_plan_card.dart';
import '../widgets/vip_question.dart';

class VipSheet {
  static void show(BuildContext context, {bool timer = false}) {
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
    Future.delayed(Duration(seconds: 5), () {
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
    final themeBrightness = Theme.of(context).brightness;
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final isDark = themeBrightness == Brightness.dark ||
        (themeBrightness == Brightness.dark &&
            systemBrightness == Brightness.dark);

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
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Text(
                    'Welcome to premium version',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 32,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                Image.asset(
                  Assets.premium,
                  height: 150,
                ),
                const SizedBox(height: 64),
                const VipFeature(
                  title:
                      'Artificial Intelligence Without Limits — Assistance 24/7.',
                ),
                const VipFeature(
                  title: 'Data Export and Import — Easy Data Handling.',
                ),
                const VipFeature(
                  title: 'Advanced Analytics — Insights for Decision-Making.',
                ),
                const VipFeature(
                  title: 'Image attachment to transcations',
                ),
              ],
            );
          }

          if (state is VipsLoaded) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 100),
                Text(
                  'Apple App of the day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const SvgWidget(Assets.stars),
                SizedBox(
                  height: 50,
                  child: SvgWidget(isDark ? Assets.leaves1 : Assets.leaves2),
                ),
                if (widget.timer) ...[
                  const SizedBox(height: 16),
                  Text(
                    '23:59:43',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 36,
                      fontFamily: AppFonts.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const VipFeature(
                    title:
                        'Artificial Intelligence Without Limits — Assistance 24/7.',
                  ),
                  const VipFeature(
                    title: 'Data Export and Import — Easy Data Handling.',
                  ),
                  const VipFeature(
                    title: 'Advanced Analytics — Insights for Decision-Making.',
                  ),
                  const VipFeature(
                    title: 'Image attachment to transcations',
                  ),
                ] else ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Choose a plan',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontFamily: AppFonts.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Free',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 14,
                              fontFamily: AppFonts.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Premium',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 14,
                              fontFamily: AppFonts.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const VipFeature(
                    title: 'Artificial Intelligence Without Limits',
                    timer: false,
                  ),
                  const VipFeature(
                    title: 'Data Export and Import',
                    timer: false,
                  ),
                  const VipFeature(
                    title: 'Advanced Analytics',
                    timer: false,
                  ),
                  const VipFeature(
                    title: 'Image attachment to transcations',
                    timer: false,
                  ),
                  const SizedBox(height: 8),
                ],
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
                if (widget.timer) ...[
                  const SizedBox(height: 16),
                  if (product != null) ...[
                    Text(
                      'Automatically renews for ${product!.price} / ${yearly ? 'year' : 'month'} until canceled.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 12,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    'Frequently asked questions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const VipQuestion(
                    title: 'Why should I upgrade to Premium?',
                    description:
                        'Our premium verison has won the hearts of over 10,000 users! Enjoy powerful budgeting tools, custom reports, and seamless expense tracking - all designed to simplify your financial journey.',
                  ),
                  const VipQuestion(
                    title: 'How do I cancel my subscription?',
                    description:
                        'Go to Settings > Your Name > Subscriptions on your iPhone, select our app, and tap Cancel Subscription.',
                  ),
                  const VipQuestion(
                    title: 'Is my data secure?',
                    description:
                        'Absolutely! We maintain complete confidentiality of your financial information. Your data is never shared or distributed to third parties. Your privacy is our priority.',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Any questions?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 24,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Button(
                    onPressed: () {},
                    minSize: 40,
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color: colors.accent,
                        fontSize: 14,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 36),
                if (state.products.isNotEmpty) ...[
                  MainButton(
                    title: widget.timer ? 'Unlock Features' : 'Upgrade Pro',
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
