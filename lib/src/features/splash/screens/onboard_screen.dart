import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../home/screens/home_screen.dart';
import '../../vip/screens/vip_screen.dart';
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
    VipSheet.show(context);
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  index == 2
                      ? Assets.onb2
                      : index == 3
                          ? Assets.onb3
                          : Assets.onb1,
                ),
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
                  colors.accent.withValues(alpha: 0.2),
                  colors.bg,
                  colors.bg,
                ],
              ),
            ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    index == 1
                        ? l.onb1
                        : index == 2
                            ? l.onb2
                            : l.onb3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 36,
                      fontFamily: AppFonts.black,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                ButtonWrapper(
                  button: MainButton(
                    title: index == 3 ? l.getStarted : l.next,
                    onPressed: onNext,
                  ),
                ),
              ],
            ),
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
