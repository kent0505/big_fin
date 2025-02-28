import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/router.dart';
import '../../../core/widgets/loading_widget.dart';
import '../data/onboard_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          context.go(context.read<OnboardRepository>().isOnBoard()
              ? AppRoutes.onboard
              : AppRoutes.home);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return context.read<OnboardRepository>().isOnBoard()
          //           ? OnboardScreen()
          //           : HomeScreen();
          //     },
          //   ),
          //   (route) => false,
          // );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
