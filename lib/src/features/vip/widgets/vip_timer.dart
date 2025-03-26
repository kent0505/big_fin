import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../bloc/bloc/vip_bloc.dart';

class VipTimer extends StatefulWidget {
  const VipTimer({super.key});

  @override
  State<VipTimer> createState() => _VipTimerState();
}

class _VipTimerState extends State<VipTimer> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  void startCountdown(int timestamp) {
    logger('STARTED');
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int diff = (timestamp ~/ 1000) - now;
    if (diff <= 0) return;
    _remainingTime = Duration(seconds: diff);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime -= Duration(seconds: 1);
        });
      }
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:"
        "${twoDigits(duration.inMinutes.remainder(60))}:"
        "${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void initState() {
    super.initState();
    final state = context.read<VipBloc>().state;
    if (state is VipsLoaded) {
      startCountdown(state.seconds);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      formatTime(_remainingTime),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 36,
        fontFamily: AppFonts.black,
      ),
    );
  }
}
