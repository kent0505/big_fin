import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';
import '../../../core/models/cat.dart';
import '../../../core/models/expense.dart';
import '../../category/bloc/category_bloc.dart';
import '../../vip/bloc/bloc/vip_bloc.dart';
import '../../vip/screens/vip_screen.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/attached_image.dart';
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

  String attachment1 = '';
  String attachment2 = '';
  String attachment3 = '';

  ImagePicker picker = ImagePicker();
  XFile image = XFile('');

  Future<XFile> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return XFile('');
      return image;
    } catch (e) {
      logger(e);
      return XFile('');
    }
  }

  void onAttachment(int id) async {
    image = await pickImage();

    setState(() {
      if (image.path.isNotEmpty) {
        if (id == 1) attachment1 = image.path;
        if (id == 2) attachment2 = image.path;
        if (id == 3) attachment3 = image.path;
      }
    });
  }

  void checkActive() {
    setState(() {
      active = [
        titleController,
        amountController,
      ].every(
        (element) => element.text.isNotEmpty && cat.title.isNotEmpty,
      );
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
          mode: PickerMode.date,
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
          mode: PickerMode.time,
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
      attachment1: attachment1,
      attachment2: attachment2,
      attachment3: attachment3,
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
    final l = AppLocalizations.of(context)!;
    final state = context.watch<VipBloc>().state;

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
                TitleText(
                  isIncome ? l.typeTitleForIncome : l.typeTitleForExpense,
                ),
                const SizedBox(height: 6),
                TxtField(
                  controller: titleController,
                  hintText: '${l.ex}: Salary',
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 8),
                TitleText(
                  isIncome ? l.typeAmountOfIncome : l.typeAmountOfExpense,
                ),
                const SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  hintText: '${l.ex}: \$150.50',
                  number: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                const SizedBox(height: 12),
                TitleText(l.chooseCategory),
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
                TitleText(l.otherDetails),
                const SizedBox(height: 6),
                TxtField(
                  controller: noteController,
                  hintText: l.writeANote,
                  multiline: true,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                if (attachment1.isEmpty) ...[
                  const SizedBox(height: 8),
                  _Attachment(
                    onPressed: () {
                      state is VipPurchased
                          ? onAttachment(1)
                          : VipSheet.show(context);
                    },
                  ),
                ] else ...[
                  const SizedBox(height: 20),
                  TitleText(l.addedAttachments),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      AttachedImage(
                        path: attachment1,
                        onPressed: () {
                          onAttachment(1);
                        },
                      ),
                      SizedBox(width: 8),
                      AttachedImage(
                        path: attachment2,
                        onPressed: () {
                          onAttachment(2);
                        },
                      ),
                      SizedBox(width: 8),
                      AttachedImage(
                        path: attachment3,
                        onPressed: () {
                          onAttachment(3);
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          ButtonWrapper(
            button: MainButton(
              title: l.save,
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
    final l = AppLocalizations.of(context)!;

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
            title: l.income,
            value: true,
            current: isIncome,
            onPressed: onPressed,
          ),
          _Mode(
            title: l.expense,
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

class _Attachment extends StatelessWidget {
  const _Attachment({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

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
            SvgWidget(
              Assets.diamond,
              height: 24,
            ),
            SizedBox(width: 8),
            SvgWidget(
              Assets.attachment,
              color: colors.textPrimary,
            ),
            SizedBox(width: 8),
            Text(
              l.addAttachment,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
            Spacer(),
            SvgWidget(Assets.right),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
