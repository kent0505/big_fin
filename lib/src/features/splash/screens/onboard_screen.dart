import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../data/onboard_repository.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 1;

  String getTitle() {
    if (index == 1) return 'Track your income and expenses';
    if (index == 2) return 'Easily track and calculate your utility costs';
    if (index == 3) return 'Ask AI for smart financial guidance.';
    return 'Track your income and expenses';
  }

  String getAsset() {
    if (index == 1) return Assets.onb1;
    if (index == 2) return Assets.onb2;
    if (index == 3) return Assets.onb3;
    return Assets.onb1;
  }

  void onNext() {
    if (index == 3) {
      onSkip();
    } else {
      setState(() {
        index++;
      });
    }
  }

  void onSkip() {
    context.read<OnboardRepository>().removeOnboard();
    context.go(AppRoutes.home);
    context.push(AppRoutes.vip);
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomeScreen()),
    //   (route) => false,
    // );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VipScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 298),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(getAsset()),
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
                  Color(0xff09B668).withValues(alpha: 0.2),
                  Color(0xff09B668).withValues(alpha: 0.4),
                  Color(0xff0D653D),
                  Color(0xff121212),
                  Color(0xff121212),
                  Color(0xff121212),
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
                _Indicator(active: index >= 1),
                SizedBox(width: 8),
                _Indicator(active: index >= 2),
                SizedBox(width: 8),
                _Indicator(active: index == 3),
                SizedBox(width: 8),
                Button(
                  onPressed: onSkip,
                  minSize: 50,
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.main,
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
            child: Container(
              height: 298,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    getTitle().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: AppFonts.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  MainButton(
                    title: index == 3 ? 'Get Started' : 'Next',
                    onPressed: onNext,
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: 80,
      decoration: BoxDecoration(
        color: Color(0xff313131),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 0),
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.circular(7),
            ),
            width: active ? 80 : 0,
          ),
        ],
      ),
    );
  }
}
