import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../../../core/models/cat.dart';
import '../../category/bloc/category_bloc.dart';
import '../bloc/budget_bloc.dart';

class AddLimitsScreen extends StatelessWidget {
  const AddLimitsScreen({super.key, required this.budget});

  final Budget budget;

  static const routePath = '/AddLimitsScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Appbar(title: 'Add limits'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return state is CategoriesLoaded
                        ? Text(
                            '${state.categories.length} categories included',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 14,
                              fontFamily: AppFonts.bold,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
                SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: budget.cats.length,
                  itemBuilder: (context, index) {
                    return _CatLimit(cat: budget.cats[index]);
                  },
                ),
              ],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: 'Save',
              onPressed: () {
                context.read<BudgetBloc>().add(AddBudget(budget: budget));
                context.pop();
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CatLimit extends StatelessWidget {
  const _CatLimit({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          SizedBox(
            width: 24,
            child: SvgWidget(
              'assets/categories/cat${cat.assetID}.svg',
              width: 24,
              color: cat.colorID == 0 ? null : getColor(cat.colorID),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              cat.title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            width: 150,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                DecimalInputFormatter(),
              ],
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontFamily: AppFonts.bold,
              ),
              decoration: InputDecoration(
                hintText: 'No limits',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 0,
                ),
                fillColor: colors.tertiaryFour,
              ),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                cat.limit = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
