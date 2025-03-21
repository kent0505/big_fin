import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      child: SizedBox(
        width: 270,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 0.5,
              color: Color(0xff545458).withValues(alpha: 0.65),
            ),
            Button(
              onPressed: () {
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OK',
                    style: TextStyle(
                      color: colors.blue,
                      fontSize: 16,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
