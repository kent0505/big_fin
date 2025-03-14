import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class AttachedImage extends StatelessWidget {
  const AttachedImage({
    super.key,
    required this.path,
    this.onPressed,
  });

  final String path;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Container(
        height: 164,
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Button(
          onPressed: onPressed,
          child: Center(
            child: path.isEmpty
                ? SvgWidget(Assets.photo)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox();
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
