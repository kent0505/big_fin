import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/models/cat.dart';
import '../../category/bloc/category_bloc.dart';
import '../../expense/widgets/category_choose.dart';
import '../bloc/home_bloc.dart';

class SortCategories extends StatelessWidget {
  const SortCategories({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return state is CategoriesLoaded
              ? ListView(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _All(cat: cat),
                    ...List.generate(
                      state.categories.length,
                      (index) {
                        return CategoryChoose(
                          cat: state.categories[index],
                          current: cat,
                          onPressed: (value) {
                            context
                                .read<HomeBloc>()
                                .add(SortByCategory(cat: value));
                          },
                        );
                      },
                    ),
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }
}

class _All extends StatelessWidget {
  const _All({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: () {
        context.read<HomeBloc>().add(SortByCategory(cat: emptyCat));
      },
      minSize: 32,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 32,
        width: 36,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: cat.id == 0 ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: cat.id == 0 ? colors.accent : colors.tertiaryFour,
          ),
        ),
        child: Center(
          child: Text(
            'All',
            style: TextStyle(
              color: cat.id == 0 ? Colors.black : colors.textPrimary,
              fontSize: 14,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
      ),
    );
  }
}
