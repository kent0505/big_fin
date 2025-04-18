import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/title_text.dart';
import '../../../core/widgets/txt_field.dart';
import '../../settings/data/settings_repository.dart';
import '../../../core/utils.dart';
import '../bloc/budget_bloc.dart';
import '../widgets/budget_period_tab.dart';
import '../widgets/budget_picker.dart';

class EditBudgetScreen extends StatefulWidget {
  const EditBudgetScreen({super.key, required this.budget});

  final Budget budget;

  static const routePath = '/EditBudgetScreen';

  @override
  State<EditBudgetScreen> createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  final dateController = TextEditingController();
  final amountController = TextEditingController();

  bool monthly = true;
  bool active = true;

  void checkActive() {
    setState(() {
      active = [
        dateController,
        amountController,
      ].every((element) => element.text.isNotEmpty);
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

  void onEdit() {
    final budget = Budget(
      id: widget.budget.id,
      monthly: monthly,
      date: dateController.text,
      amount: amountController.text,
    );
    context.read<BudgetBloc>().add(CheckBudget(budget: budget));
  }

  void onDelete() {
    final l = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: l.areYouSure,
          description: l.deleteDescription,
          leftTitle: l.delete,
          rightTitle: l.cancel,
          onYes: () {
            context.read<BudgetBloc>().add(DeleteBudget(budget: widget.budget));
            context.pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dateController.text = widget.budget.date;
    amountController.text = widget.budget.amount;
    monthly = widget.budget.monthly;
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final currency = context.read<SettingsRepository>().getCurrency();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        title: l.editBudget,
        right: Button(
          onPressed: onDelete,
          child: SvgWidget(Assets.delete),
        ),
      ),
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
              ],
            ),
          ),
          BlocListener<BudgetBloc, BudgetState>(
            listener: (context, state) {
              if (state is BudgetExists) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return InfoDialog(
                      title: l.dateAlreadyExists,
                    );
                  },
                );
              }

              if (state is BudgetNotExists) {
                context.read<BudgetBloc>().add(
                      EditBudget(
                        budget: Budget(
                          id: widget.budget.id,
                          monthly: monthly,
                          date: dateController.text,
                          amount: amountController.text,
                        ),
                      ),
                    );
                context.pop();
              }
            },
            child: ButtonWrapper(
              button: MainButton(
                title: l.edit,
                active: active,
                onPressed: onEdit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
