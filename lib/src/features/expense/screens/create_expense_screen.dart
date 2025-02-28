import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/ios_date_picker.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final noteController = TextEditingController();

  void onDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return IosDatePicker(
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
    categoryController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Appbar(title: 'Create'),
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
                ),
                SizedBox(height: 8),
                _TitleText('Type amount of income'),
                SizedBox(height: 6),
                TxtField(
                  controller: amountController,
                  hintText: 'Ex: \$150.50',
                ),
                SizedBox(height: 12),
                _TitleText('Choose category'),
                SizedBox(height: 14),
                Wrap(
                  children: [
                    // categories
                  ],
                ),
                SizedBox(height: 20),
                _TitleText('Other details'),
                SizedBox(height: 6),
                TxtField(
                  controller: noteController,
                  hintText: 'Write a note',
                  multiline: true,
                ),
                SizedBox(height: 8),
                TxtField(
                  controller: noteController,
                  hintText: 'Write a note',
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
            color: Color(0xff121212),
            child: MainButton(
              title: 'Save',
              onPressed: () {},
            ),
          ),
        ],
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
                    fontFamily: AppFonts.bold,
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
