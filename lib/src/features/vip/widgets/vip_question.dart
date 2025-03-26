import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class VipQuestion extends StatefulWidget {
  const VipQuestion({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  State<VipQuestion> createState() => _VipQuestionState();
}

class _VipQuestionState extends State<VipQuestion> {
  bool expanded = false;

  void onExpand() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Button(
        onPressed: onExpand,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SvgWidget(
                  expanded ? Assets.top : Assets.bottom,
                  width: 24,
                  color: colors.textPrimary,
                ),
                const SizedBox(width: 16),
              ],
            ),
            SizedBox(height: expanded ? 12 : 16),
            if (expanded) ...[
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: colors.tertiaryFour,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                    fontFamily: AppFonts.medium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
