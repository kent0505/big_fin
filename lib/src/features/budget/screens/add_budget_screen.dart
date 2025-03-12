import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void checkActive() {
    setState(() {
      active = [
        dateController,
        amountController,
      ].every(
        (element) =>
            element.text.isNotEmpty && cat.title.isNotEmpty || selectAll,
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
        id: getTimestamp(),
        monthly: monthly,
        date: dateController.text,
        amount: amountController.text,
        cats: selectAll ? defaultCats : [cat],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dateController.text = getMonthYear(DateTime.now());
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Appbar(title: 'Add budget'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _PeriodSelect(
                  monthly: monthly,
                  onPeriod: onPeriod,
                ),
                const SizedBox(height: 28),
                const TitleText('Budget for'),
                const SizedBox(height: 6),
                _Picker(
                  controller: dateController,
                  onPressed: onDate,
                ),
                const SizedBox(height: 12),
                const TitleText('Your total budget limit'),
                const SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  number: true,
                  hintText: 'Ex: \$150',
                ),
                const SizedBox(height: 12),
                const TitleText('Select included categories'),
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
                          'Select All',
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
                  itemCount: defaultCats.length,
                  itemBuilder: (context, index) {
                    return _CategoryButton(
                      cat: defaultCats[index],
                      active: selectAll || defaultCats[index].id == cat.id,
                      onPressed: onCat,
                    );
                  },
                ),
              ],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: 'Next',
              active: active,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodSelect extends StatelessWidget {
  const _PeriodSelect({
    required this.monthly,
    required this.onPeriod,
  });

  final bool monthly;
  final void Function(bool) onPeriod;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _Tab(
            title: 'Monthly',
            active: monthly,
            onPeriod: () {
              onPeriod(true);
            },
          ),
          _Tab(
            title: 'Yearly',
            active: !monthly,
            onPeriod: () {
              onPeriod(false);
            },
          ),
        ],
      ),
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Text(
                controller.text,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontFamily: AppFonts.dosis,
                ),
              ),
            ),
            SizedBox(width: 4),
            SvgWidget(
              Assets.date1,
              color: colors.textPrimary,
            ),
            SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.active,
    required this.onPeriod,
  });

  final String title;
  final bool active;
  final VoidCallback onPeriod;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: active ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Button(
          onPressed: onPeriod,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: active ? Colors.black : colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.cat,
    required this.active,
    required this.onPressed,
  });

  final Cat cat;
  final bool active;
  final void Function(Cat) onPressed;

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
      child: Button(
        onPressed: () {
          onPressed(cat);
        },
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
            SizedBox(width: 4),
            if (active) SvgWidget(Assets.check),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
