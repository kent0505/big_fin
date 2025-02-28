import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Appbar(title: 'Theme'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _ThemeButton(
                  title: 'Device theme',
                  active: true,
                  onPressed: () {},
                ),
                _ThemeButton(
                  title: 'Light',
                  active: false,
                  onPressed: () {},
                ),
                _ThemeButton(
                  title: 'Dark',
                  active: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            if (active)
              SizedBox(
                width: 24,
                child: SvgWidget(Assets.check),
              ),
            SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}
