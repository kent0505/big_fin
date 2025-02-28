import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'button.dart';

class IosDatePicker extends StatelessWidget {
  const IosDatePicker({
    super.key,
    this.timePicker = false,
    this.initialDateTime,
    required this.onDateTimeChanged,
    required this.onDone,
  });

  final bool timePicker;
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 252,
      color: Color(0xffE9E9E9),
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
                      color: Color(0xff007AFF),
                      fontSize: 17,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ),
              ),
              Expanded(
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Color(0xff007AFF),
                      fontSize: 17,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: AppFonts.medium,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: onDateTimeChanged,
                initialDateTime: initialDateTime,
                mode: timePicker
                    ? CupertinoDatePickerMode.time
                    : CupertinoDatePickerMode.date,
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
