import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../home/screens/home_screen.dart';
import '../../vip/widgets/stars_widget.dart';
import '../data/onboard_repository.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;
  Timer? timer;

  void onNext() {
    if (index == 3) {
      onSkip();
    } else {
      setState(() {
        index++;
      });
    }
    logger(index);
  }

  void onSkip() {
    timer?.cancel();
    context.read<OnboardRepository>().removeOnboard();
    context.go(HomeScreen.routePath);
  }

  void start() {
    Future.delayed(Duration.zero, () {
      setState(() {
        index++;
      });
    });
    timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        index == 3 ? timer.cancel() : onNext();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              if (index == 1) ...[
                StarsWidget(title: l.popularChoice),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Spacer(),
                    _RewiewCard(
                      asset: Assets.onb1,
                      name: 'Sophia Carter',
                      country: 'London, Great Britain',
                      title: 'Excellent expense tracker!',
                      description:
                          'User-friendly design, great features, and helps keep finances organized with ease. Highly recommend!',
                    ),
                    const SizedBox(width: 22),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 22),
                    _RewiewCard(
                      asset: Assets.onb2,
                      name: 'Lukas Müller',
                      country: 'Hamburg, Deutschland',
                      title: 'Fantastischer Ausgaben-Tracker!',
                      description:
                          ' Die Benutzeroberfläche ist intuitiv und die Funktionen helfen, meine Finanzen einfach zu verwalten. Sehr empfehlenswert!',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    const _RewiewCard(
                      asset: Assets.onb3,
                      name: 'Carmen García',
                      country: 'Barcelona, España',
                      title: '¡Una increíble app para seguir los gastos!',
                      description:
                          '¡Excelente app para seguir los gastos! Fácil de usar y con funciones útiles. ¡Muy recomendable para gestionar el dinero!',
                    ),
                    const SizedBox(width: 22),
                  ],
                ),
              ] else if (index == 2) ...[
                const _Message(
                  message:
                      'That sounds helpful! Also, how can I avoid impulse spending?',
                  fromGPT: false,
                ),
                const SizedBox(height: 16),
                const _Message(
                  message:
                      'A great trick is the 24-hour rule—before making a non-essential purchase, wait a day. This helps separate wants from needs. Also, setting a weekly spending limit can keep you on track.',
                  fromGPT: true,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        Assets.onb4,
                        height: 164,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: colors.tertiaryOne,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              'Ask me anything...',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 14,
                                fontFamily: AppFonts.medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    SvgWidget(
                      Assets.send,
                      color: colors.textPrimary,
                    ),
                    const SizedBox(width: 26),
                  ],
                ),
              ] else if (index == 3) ...[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 24,
                    children: List.generate(
                      defaultCats.length,
                      (index) {
                        return _Category(cat: defaultCats[index]);
                      },
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Indicator(
                  active: index >= 1,
                  filled: index == 2 || index == 3,
                ),
                const SizedBox(width: 8),
                _Indicator(
                  active: index >= 2,
                  filled: index == 3,
                ),
                const SizedBox(width: 8),
                _Indicator(active: index == 3),
                const SizedBox(width: 8),
                Button(
                  onPressed: onSkip,
                  minSize: 50,
                  child: Center(
                    child: Text(
                      l.skip,
                      style: TextStyle(
                        color: colors.accent,
                        fontSize: 14,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  index == 2
                      ? l.onb2
                      : index == 3
                          ? l.onb3
                          : l.onb1,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 36,
                    fontFamily: AppFonts.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  index == 2
                      ? l.onb5
                      : index == 3
                          ? l.onb6
                          : l.onb4,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontFamily: AppFonts.medium,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ButtonWrapper(
                button: MainButton(
                  title: index == 3 ? l.getStarted : l.next,
                  onPressed: onNext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.active,
    this.filled = false,
  });

  final bool active;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 7,
      width: 80,
      decoration: BoxDecoration(
        color: colors.tertiaryFour,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 4),
            height: 7,
            width: active ? 80 : 0,
            decoration: BoxDecoration(
              color: colors.accent,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          if (filled)
            Container(
              height: 7,
              width: 80,
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
        ],
      ),
    );
  }
}

class _RewiewCard extends StatelessWidget {
  const _RewiewCard({
    required this.asset,
    required this.name,
    required this.country,
    required this.title,
    required this.description,
  });

  final String asset;
  final String name;
  final String country;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      width: 212,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 38,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: Image.asset(
                asset,
                height: 38,
                width: 38,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 10,
              fontFamily: AppFonts.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            country,
            style: TextStyle(
              color: colors.textThree,
              fontSize: 6,
              fontFamily: AppFonts.medium,
            ),
          ),
          SizedBox(height: 2),
          SvgWidget(
            Assets.stars,
            height: 7,
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 8,
              fontFamily: AppFonts.medium,
            ),
          ),
          SizedBox(height: 2),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 7,
              fontFamily: AppFonts.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.message,
    required this.fromGPT,
  });

  final String message;
  final bool fromGPT;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Row(
      children: [
        if (!fromGPT) Spacer(),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: fromGPT ? colors.tertiaryOne : colors.tertiaryFour,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ),
        ),
        if (fromGPT) Spacer(),
      ],
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          width: 1.3,
          color: colors.textPrimary,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 10),
          SizedBox(
            width: 24,
            child: SvgWidget(
              'assets/categories/cat${cat.assetID}.svg',
              height: 24,
            ),
          ),
          SizedBox(width: 5),
          Text(
            cat.title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontFamily: AppFonts.bold,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
