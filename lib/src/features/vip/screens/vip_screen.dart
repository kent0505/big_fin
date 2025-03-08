import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/vip.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  Vip vip = vipsList.last;

  void onPlan(Vip value) {
    setState(() {
      vip = value;
    });
  }

  void onSubscribe() {}

  final List<String> features = [
    'Unlock access to the AI assistant.',
    'Export data for easy analysis and\narchiving.',
    'Import data to easily access.',
    'Advanced analytics for deeper insights.',
    'No ads, just pure content.',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // margin: const EdgeInsets.only(bottom: 298),
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
                  'Go Premium',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 32,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                const SizedBox(height: 26),
                ...List.generate(
                  features.length,
                  (index) {
                    return _Feature(title: features[index]);
                  },
                ),
                ...List.generate(
                  vipsList.length,
                  (index) {
                    return _PlanCard(
                      vip: vipsList[index],
                      current: vip,
                      onPressed: onPlan,
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Automatically renews for \$200.00 / month until canceled.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 12,
                    fontFamily: AppFonts.medium,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWrapper(
              button: MainButton(
                title: 'Subscribe',
                onPressed: onSubscribe,
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
    required this.vip,
    required this.current,
    required this.onPressed,
  });

  final Vip vip;
  final Vip current;
  final void Function(Vip) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
        border: vip.id == current.id
            ? Border.all(
                width: 1.5,
                color: colors.accent,
              )
            : null,
      ),
      child: Button(
        onPressed: () {
          onPressed(vip);
        },
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: vip.id == current.id ? colors.accent : null,
                border: Border.all(
                  width: 2,
                  color: vip.id == current.id
                      ? colors.accent
                      : colors.textSecondary,
                ),
              ),
              child: Center(
                child: SvgWidget(
                  Assets.check,
                  color: vip.id == current.id ? colors.bg : Colors.transparent,
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
                    vip.title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vip.description,
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
                  '\$${vip.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                if (vip.previousPrice != 0)
                  Text(
                    '\$${vip.previousPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                      decoration: TextDecoration.lineThrough,
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
