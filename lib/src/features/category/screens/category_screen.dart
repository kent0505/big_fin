import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/router.dart';
import '../../../core/widgets/appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Appbar(
            title: 'Categories',
            onAdd: () {
              context.push(AppRoutes.addCategory);
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
