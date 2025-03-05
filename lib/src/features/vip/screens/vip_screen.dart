import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  double price = 200;

  void onPlan(double value) {
    setState(() {
      price = value;
    });
  }

  void onSubscribe() {}

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 298),
            decoration: BoxDecoration(
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
                  Color(0xff09B668).withValues(alpha: 0),
                  Color(0xff09B668).withValues(alpha: 0.4),
                  Color(0xff121212),
                  Color(0xff121212),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const SizedBox(height: 140),
                    Text(
                      'Go Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 32,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    const SizedBox(height: 26),
                    _Feature(title: 'Unlock access to the AI assistant.'),
                    _Feature(
                        title: 'Export data for easy analysis and\narchiving.'),
                    _Feature(title: 'Import data to easily access.'),
                    _Feature(title: 'Advanced analytics for deeper insights.'),
                    _Feature(title: 'No ads, just pure content.'),
                    _PlanCard(
                      title: 'Weekly Plan',
                      description: 'Pay every week',
                      price: 20,
                      active: price,
                      onPressed: onPlan,
                    ),
                    _PlanCard(
                      title: 'Monthly Plan',
                      description: 'Pay every month',
                      price: 150,
                      active: price,
                      onPressed: onPlan,
                    ),
                    _PlanCard(
                      title: 'Yearly Plan',
                      description: 'Pay every year',
                      price: 200,
                      price2: 399.99,
                      active: price,
                      onPressed: onPlan,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Automatically renews for \$200.00 / month until canceled.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 12,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                height: 112,
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
                alignment: Alignment.topCenter,
                color: colors.bg,
                child: MainButton(
                  title: 'Subscribe',
                  onPressed: onSubscribe,
                ),
              ),
            ],
          ),
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
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.description,
    required this.price,
    this.price2 = 0,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final String description;
  final double price;
  final double price2;
  final double active;
  final void Function(double) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
        border: price == active
            ? Border.all(
                width: 1.5,
                color: colors.accent,
              )
            : null,
      ),
      child: Button(
        onPressed: () {
          onPressed(price);
        },
        child: Row(
          children: [
            SizedBox(width: 12),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: price == active ? colors.accent : null,
                border: Border.all(
                  width: 2,
                  color: price == active ? colors.accent : colors.textSecondary,
                ),
              ),
              child: Center(
                child: SvgWidget(
                  Assets.check,
                  color: colors.bg,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
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
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                if (price2 != 0)
                  Text(
                    '\$${price2.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16),
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
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgWidget(
            Assets.check,
            color: colors.accent,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.bold,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
