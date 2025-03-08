import 'package:big_fin/src/core/config/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';

class IosDatePicker extends StatelessWidget {
  const IosDatePicker({
    super.key,
    required this.mode,
    this.initialDateTime,
    required this.onDateTimeChanged,
    required this.onDone,
  });

  // final bool timePicker;
  final PickerMode mode;
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 252,
      color: const Color(0xffE9E9E9),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 70,
                child: Button(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: colors.blue,
                      fontSize: 17,
                      fontFamily: AppFonts.sf,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                child: Button(
                  onPressed: () {
                    onDone();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: colors.blue,
                      fontSize: 17,
                      fontFamily: AppFonts.sf,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: AppFonts.sf,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: onDateTimeChanged,
                initialDateTime: initialDateTime,
                mode: mode == PickerMode.date
                    ? CupertinoDatePickerMode.date
                    : mode == PickerMode.time
                        ? CupertinoDatePickerMode.time
                        : CupertinoDatePickerMode.monthYear,
                use24hFormat: true,
                minimumYear: 1950,
                maximumYear: DateTime.now().year + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
