import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_card.dart';
import 'category_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const routePath = '/CategoriesScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(
        title: l.categories,
        right: Button(
          onPressed: () {
            context.push(CategoryScreen.routePath);
          },
          child: SvgWidget(
            Assets.add,
            color: colors.textPrimary,
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
                        padding: const EdgeInsets.all(16),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(cat: state.categories[index]);
                        },
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
