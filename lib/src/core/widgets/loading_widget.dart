import 'dart:async';

import 'package:flutter/material.dart';

import '../config/my_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  int _index = 0;
  late Timer _timer;

  void _start() {
    _timer = Timer.periodic(
      Duration(milliseconds: 300),
      (timer) {
        setState(() {
          _index < 2 ? _index++ : _index = 0;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Indicator(_index == 0),
          _Indicator(_index == 1),
          _Indicator(_index == 2),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator(this.active);

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: active ? 12 : 8,
      width: active ? 12 : 8,
      margin: EdgeInsets.symmetric(horizontal: active ? 2 : 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.accent,
      ),
    );
  }
}
