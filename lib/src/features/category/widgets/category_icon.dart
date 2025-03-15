import 'package:flutter/material.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.assetID,
    required this.current,
    required this.colorID,
    required this.onPressed,
  });

  final int assetID;
  final int current;
  final int colorID;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: assetID == current
          ? null
          : () {
              onPressed(assetID);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.tertiaryOne,
          border: assetID == current
              ? Border.all(
                  width: 2,
                  color: getCatColor(colorID) ?? colors.tertiaryThree,
                )
              : null,
        ),
        child: Center(
          child: SvgWidget(
            'assets/categories/cat$assetID.svg',
            color: assetID == current
                ? getCatColor(colorID) ?? colors.tertiaryThree
                : null,
          ),
        ),
      ),
    );
  }
}
