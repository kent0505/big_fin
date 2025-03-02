import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils.dart';
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
    return Button(
      onPressed: id == colorID
          ? null
          : () {
              onPressed(id);
            },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getColor(id),
          border: id == colorID
              ? Border.all(
                  width: 2,
                  color: AppColors.main,
                )
              : null,
        ),
      ),
    );
  }
}
