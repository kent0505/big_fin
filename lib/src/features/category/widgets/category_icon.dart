import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.colorID,
    required this.asset,
    required this.current,
    required this.onPressed,
  });

  final int colorID;
  final String asset;
  final String current;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        onPressed(asset);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff1B1B1B),
          border: asset == current
              ? Border.all(
                  width: 2,
                  color: colorID == 0 ? Colors.white : getColor(colorID),
                )
              : null,
        ),
        child: Center(
          child: SvgWidget(
            asset,
            color: asset == current
                ? colorID == 0
                    ? Colors.white
                    : getColor(colorID)
                : null,
          ),
        ),
      ),
    );
  }
}
