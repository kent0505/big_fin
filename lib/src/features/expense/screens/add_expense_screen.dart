import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../../category/bloc/category_bloc.dart';
import '../../category/models/cat.dart';
import '../bloc/expense_bloc.dart';
import '../models/expense.dart';
import '../widgets/category_choose.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  static const routePath = '/AddExpenseScreen';

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  Cat cat = emptyCat;

  bool isIncome = true;
  bool active = false;

  void checkActive() {
    setState(() {
      active = [
        titleController.text,
        amountController.text,
        cat.title,
      ].every((element) => element.isNotEmpty);
    });
  }

  void onMode(bool value) {
    setState(() {
      isIncome = value;
    });
  }

  void onCat(Cat value) {
    cat = value;
    checkActive();
  }

  void onDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IosDatePicker(
          initialDateTime: stringToDate(dateController.text),
          onDateTimeChanged: (value) {
            dateController.text = dateToString(value);
          },
          onDone: () {
            setState(() {});
          },
        );
      },
    );
  }

  void onTime() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IosDatePicker(
          timePicker: true,
          initialDateTime: timeToDate(timeController.text),
          onDateTimeChanged: (value) {
            timeController.text = timeToString(value);
          },
          onDone: () {
            setState(() {});
          },
        );
      },
    );
  }

  void onSave() {
    final expense = Expense(
      id: getTimestamp(),
      date: dateController.text,
      time: timeController.text,
      title: titleController.text,
      amount: amountController.text,
      note: noteController.text,
      catTitle: cat.title,
      assetID: cat.assetID,
      colorID: cat.colorID,
      isIncome: isIncome,
    );
    context.read<ExpenseBloc>().add(AddExpense(expense: expense));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    dateController.text = dateToString(now);
    timeController.text = timeToString(now);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        child: _IncExpMode(
          isIncome: isIncome,
          onPressed: onMode,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    _Picker(
                      controller: dateController,
                      onPressed: onDate,
                    ),
                    const SizedBox(width: 8),
                    _Picker(
                      controller: timeController,
                      onPressed: onTime,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _TitleText('Type title for income'),
                const SizedBox(height: 6),
                TxtField(
                  controller: titleController,
                  hintText: 'Ex: Salary',
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 8),
                _TitleText('Type amount of income'),
                const SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  hintText: 'Ex: \$150.50',
                  number: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 12),
                _TitleText('Choose category'),
                const SizedBox(height: 14),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return state is CategoriesLoaded
                        ? Wrap(
                            runSpacing: 16,
                            children: List.generate(
                              state.categories.length,
                              (index) {
                                return CategoryChoose(
                                  cat: state.categories[index],
                                  current: cat,
                                  onPressed: onCat,
                                );
                              },
                            ),
                          )
                        : const SizedBox();
                  },
                ),
                const SizedBox(height: 20),
                _TitleText('Other details'),
                const SizedBox(height: 6),
                TxtField(
                  controller: noteController,
                  hintText: 'Write a note',
                  multiline: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 8),
                // attachment
              ],
            ),
          ),
          Container(
            height: 112,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 10),
            alignment: Alignment.topCenter,
            color: colors.bg,
            child: MainButton(
              title: 'Save',
              active: active,
              onPressed: onSave,
            ),
          ),
        ],
      ),
    );
  }
}

class _IncExpMode extends StatelessWidget {
  const _IncExpMode({
    required this.isIncome,
    required this.onPressed,
  });

  final bool isIncome;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 44,
      width: 180,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _Mode(
            title: 'Income',
            value: true,
            current: isIncome,
            onPressed: onPressed,
          ),
          _Mode(
            title: 'Expense',
            value: false,
            current: isIncome,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _Mode extends StatelessWidget {
  const _Mode({
    required this.title,
    required this.value,
    required this.current,
    required this.onPressed,
  });

  final String title;
  final bool value;
  final bool current;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Button(
        onPressed: value == current
            ? null
            : () {
                onPressed(value);
              },
        minSize: 36,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: value == current ? colors.accent : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: value == current ? Colors.black : colors.textPrimary,
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

class _TitleText extends StatelessWidget {
  const _TitleText(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      title,
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 14,
        fontFamily: AppFonts.bold,
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

    return Expanded(
      child: Container(
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
      ),
    );
  }
}
