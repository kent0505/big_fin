import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/constants.dart';
import 'button.dart';
import 'svg_widget.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.title,
    this.back = true,
    this.onAdd,
  });

  final String title;
  final bool back;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            SizedBox(width: 16),
            if (back)
              Button(
                onPressed: () {
                  context.pop();
                },
                child: SvgWidget(Assets.back),
              ),
            Expanded(
              child: Text(
                title,
                textAlign: back ? TextAlign.center : null,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: back ? 18 : 24,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ),
            onAdd == null
                ? SizedBox(width: 44)
                : Button(
                    onPressed: onAdd,
                    child: SvgWidget(
                      Assets.add,
                      color: Colors.white,
                      height: 24,
                    ),
                  ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
