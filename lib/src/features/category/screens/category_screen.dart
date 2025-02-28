import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'Categories',
        right: Button(
          onPressed: () {
            context.push(AppRoutes.addCategory);
          },
          child: SvgWidget(
            Assets.add,
            height: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return state is CategoriesLoaded
                    ? ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(cat: state.categories[index]);
                        },
                      )
                    : SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
