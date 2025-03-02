import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../../category/bloc/category_bloc.dart';
import '../../category/models/cat.dart';
import '../bloc/expense_bloc.dart';
import '../models/expense.dart';
import '../widgets/category_choose.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, this.expense});

  final Expense? expense;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  Cat cat = emptyCat;

  bool isIncome = true;
  bool active = true;

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
      id: widget.expense?.id ?? getTimestamp(),
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
    context.read<ExpenseBloc>().add(widget.expense == null
        ? AddExpense(expense: expense)
        : EditExpense(expense: expense));
    Navigator.pop(context);
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: 'Are you sure?',
          description: 'You won’t be able to undo this action.',
          leftTitle: 'Delete',
          rightTitle: 'Cancel',
          onYes: () {
            context
                .read<ExpenseBloc>()
                .add(DeleteExpense(expense: widget.expense!));
            context.pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    dateController.text = widget.expense?.date ?? dateToString(now);
    timeController.text = widget.expense?.time ?? timeToString(now);
    titleController.text = widget.expense?.title ?? '';
    amountController.text = widget.expense?.amount ?? '';
    noteController.text = widget.expense?.note ?? '';
    cat.title = widget.expense?.catTitle ?? '';
    cat.assetID = widget.expense?.assetID ?? 0;
    cat.colorID = widget.expense?.colorID ?? 0;
    isIncome = widget.expense?.isIncome ?? true;
    if (widget.expense == null) active = false;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        right: widget.expense == null
            ? null
            : Button(
                onPressed: onDelete,
                child: SvgWidget(
                  Assets.delete,
                  color: Colors.white,
                ),
              ),
        child: _IncExpMode(
          isIncome: isIncome,
          onPressed: onMode,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    _Picker(
                      controller: dateController,
                      onPressed: onDate,
                    ),
                    SizedBox(width: 8),
                    _Picker(
                      controller: timeController,
                      onPressed: onTime,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _TitleText('Type title for income'),
                SizedBox(height: 6),
                TxtField(
                  controller: titleController,
                  hintText: 'Ex: Salary',
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                SizedBox(height: 8),
                _TitleText('Type amount of income'),
                SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  hintText: 'Ex: \$150.50',
                  number: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                SizedBox(height: 12),
                _TitleText('Choose category'),
                SizedBox(height: 14),
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
                        : SizedBox();
                  },
                ),
                SizedBox(height: 20),
                _TitleText('Other details'),
                SizedBox(height: 6),
                TxtField(
                  controller: noteController,
                  hintText: 'Write a note',
                  multiline: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                SizedBox(height: 8),
                // attachment
              ],
            ),
          ),
          Container(
            height: 112,
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
            alignment: Alignment.topCenter,
            color: AppColors.bg,
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
    return Container(
      height: 44,
      width: 180,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
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
            color: value == current ? AppColors.main : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: value == current ? Colors.black : Colors.white,
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
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
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
    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Color(0xff1B1B1B),
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
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.dosis,
                  ),
                ),
              ),
              SizedBox(width: 4),
              SvgWidget(Assets.date1),
              SizedBox(width: 14),
            ],
          ),
        ),
      ),
    );
  }
}
