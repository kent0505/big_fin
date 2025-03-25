import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.title,
    required this.description,
    this.onCreate,
  });

  final String title;
  final String description;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          if (onCreate != null)
            Container(
              height: 58,
              width: 180,
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Button(
                onPressed: onCreate,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgWidget(
                      Assets.add,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      l.create,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
