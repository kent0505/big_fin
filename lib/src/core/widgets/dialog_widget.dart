import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/theme/bloc/theme_bloc.dart';
import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.description,
    required this.leftTitle,
    required this.rightTitle,
    required this.onYes,
  });

  final String title;
  final String description;
  final String leftTitle;
  final String rightTitle;
  final VoidCallback onYes;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      child: SizedBox(
        width: 270,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontFamily: AppFonts.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.sf,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              height: 0.5,
              color: Color(0xff545458).withValues(alpha: 0.65),
            ),
            Row(
              children: [
                BlocBuilder<ThemeBloc, ThemeMode>(
                  builder: (context, state) {
                    bool isDarkMode = state == ThemeMode.dark ||
                        (state == ThemeMode.system &&
                            MediaQuery.of(context).platformBrightness ==
                                Brightness.dark);

                    return _Button(
                      title: leftTitle,
                      color: isDarkMode ? colors.system : colors.blue,
                      fontFamily: AppFonts.sf,
                      onPressed: () {
                        context.pop();
                        onYes();
                      },
                    );
                  },
                ),
                Container(
                  width: 0.5,
                  height: 44,
                  color: Color(0xff545458).withValues(alpha: 0.65),
                ),
                _Button(
                  title: rightTitle,
                  color: colors.blue,
                  fontFamily: AppFonts.medium,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.color,
    required this.fontFamily,
    required this.onPressed,
  });

  final String title;
  final Color color;
  final String fontFamily;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Button(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontFamily: fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
