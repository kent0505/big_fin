import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'svg_widget.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    this.number = false,
    this.decimal = true,
    this.multiline = false,
    this.search = false,
    this.close = true,
    this.maxLength = 50,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final bool number;
  final bool decimal;
  final bool multiline;
  final bool search;
  final bool close;
  final int maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return TextField(
      controller: controller,
      keyboardType:
          number ? TextInputType.numberWithOptions(decimal: decimal) : null,
      minLines: 1,
      maxLines: multiline ? 10 : 1,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
          multiline
              ? maxLength
              : number
                  ? 10
                  : 25,
        ),
        if (number)
          decimal
              ? DecimalInputFormatter()
              : FilteringTextInputFormatter.digitsOnly,
      ],
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 16,
        fontFamily: AppFonts.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: search
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgWidget(
                    Assets.search,
                    color: colors.textPrimary,
                  ),
                ],
              )
            : null,
      ),
      onTapOutside: close
          ? (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          : null,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow only numbers and one decimal point
    final text = newValue.text;
    if (RegExp(r'^[0-9]*[.,]?[0-9]*$').hasMatch(text)) {
      final dotCount = '.'.allMatches(text).length;
      final commaCount = ','.allMatches(text).length;

      if (dotCount + commaCount > 1) {
        return oldValue;
      }
      return newValue;
    }
    return oldValue;
  }
}
