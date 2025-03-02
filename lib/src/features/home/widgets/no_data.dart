import 'package:big_fin/src/core/config/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.title,
    required this.description,
    this.create = false,
  });

  final String title;
  final String description;
  final bool create;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffB0B0B0),
              fontSize: 14,
              fontFamily: AppFonts.medium,
              height: 1.6,
            ),
          ),
          SizedBox(height: 16),
          if (create)
            Container(
              height: 58,
              width: 180,
              decoration: BoxDecoration(
                color: AppColors.main,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Button(
                onPressed: () {
                  context.push(AppRoutes.expense);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgWidget(
                      Assets.add,
                      color: AppColors.bg,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Create',
                      style: TextStyle(
                        color: AppColors.bg,
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
