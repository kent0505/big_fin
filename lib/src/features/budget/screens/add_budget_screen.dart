import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';
import '../../../core/utils.dart';
import '../../category/bloc/category_bloc.dart';
import '../../settings/data/settings_repository.dart';
import '../widgets/budget_cat_button.dart';
import '../widgets/budget_period_tab.dart';
import '../widgets/budget_picker.dart';
import 'add_limits_screen.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  static const routePath = '/AddBudgetScreen';

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final dateController = TextEditingController();
  final amountController = TextEditingController();

  bool monthly = true;
  bool selectAll = false;
  bool active = false;

  Cat cat = emptyCat;
  List<Cat> categories = [];

  void checkActive() {
    setState(() {
      active = [
        dateController,
        amountController,
      ].every(
        (element) =>
            element.text.isNotEmpty && (cat.title.isNotEmpty || selectAll),
      );
    });
  }

  void onDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IosDatePicker(
          mode: PickerMode.monthYear,
          initialDateTime: monthToDate(dateController.text),
          onDateTimeChanged: (value) {
            dateController.text = getMonthYear(value);
          },
          onDone: () {
            setState(() {});
          },
        );
      },
    );
  }

  void onPeriod(bool value) {
    setState(() {
      monthly = value;
    });
  }

  void onAll() {
    selectAll = true;
    cat = emptyCat;
    checkActive();
  }

  void onCat(Cat value) {
    cat = value;
    selectAll = false;
    checkActive();
  }

  void onNext() {
    context.push(
      AddLimitsScreen.routePath,
      extra: Budget(
        id: 0,
        monthly: monthly,
        date: dateController.text,
        amount: amountController.text,
        cats: selectAll ? categories : [cat],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dateController.text = getMonthYear(DateTime.now());
    categories = context.read<CategoryBloc>().categories;
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final currency = context.read<SettingsRepository>().getCurrency();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(title: l.addBudget),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                BudgetPeriodTab(
                  monthly: monthly,
                  onPeriod: onPeriod,
                ),
                const SizedBox(height: 28),
                TitleText(l.budgetFor),
                const SizedBox(height: 6),
                BudgetPicker(
                  controller: dateController,
                  onPressed: onDate,
                ),
                const SizedBox(height: 12),
                TitleText(l.yourTotalBudgetLimit),
                const SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  number: true,
                  hintText: '${l.ex}: ${currency}150',
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 12),
                TitleText(l.selectIncludedCategories),
                const SizedBox(height: 6),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors.tertiaryOne,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Button(
                    onPressed: onAll,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          l.selectAll,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontFamily: AppFonts.medium,
                          ),
                        ),
                        const Spacer(),
                        if (selectAll) SvgWidget(Assets.check),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return BudgetCatButton(
                      cat: categories[index],
                      active: selectAll || categories[index].id == cat.id,
                      onPressed: onCat,
                    );
                  },
                ),
              ],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: l.next,
              active: active,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
