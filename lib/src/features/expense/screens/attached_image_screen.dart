import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.path});

  final String path;

  static const routePath = '/ImageViewScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.file(
            File(path),
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
