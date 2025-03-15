import 'package:flutter/material.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class CategoryColor extends StatelessWidget {
  const CategoryColor({
    super.key,
    required this.id,
    required this.colorID,
    required this.onPressed,
  });

  final int id;
  final int colorID;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: id == colorID
          ? null
          : () {
              onPressed(id);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getCatColor(id),
          border: id == colorID
              ? Border.all(
                  width: 2,
                  color: colors.accent,
                )
              : null,
        ),
      ),
    );
  }
}
