import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../bloc/bloc/vip_bloc.dart';

class VipTimer extends StatefulWidget {
  const VipTimer({super.key});

  @override
  State<VipTimer> createState() => _VipTimerState();
}

class _VipTimerState extends State<VipTimer> {
  String formatTime(int time) {
    int hours = time ~/ 10000; // Extract HH
    int minutes = (time ~/ 100) % 100; // Extract MM
    int seconds = time % 100; // Extract SS
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return BlocBuilder<VipBloc, VipState>(
      builder: (context, state) {
        return state is VipsLoaded
            ? Text(
                formatTime(state.seconds),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 36,
                  fontFamily: AppFonts.black,
                ),
              )
            : const SizedBox();
      },
    );
  }
}
