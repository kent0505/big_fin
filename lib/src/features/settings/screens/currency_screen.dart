import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../data/settings_repository.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  static const routePath = '/CurrencyScreen';

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String currency = '\$';

  void onCurrency(String value) async {
    await context.read<SettingsRepository>().setCurrency(value);
    setState(() {
      currency = value;
    });
  }

  @override
  void initState() {
    super.initState();
    currency = context.read<SettingsRepository>().getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final currencies = Currencies.values;

    return Scaffold(
      appBar: Appbar(title: l.currency),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return _CurrencyButton(
            currency: currencies[index],
            cyrrent: currency,
            onPressed: onCurrency,
          );
        },
      ),
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  const _CurrencyButton({
    required this.currency,
    required this.cyrrent,
    required this.onPressed,
  });

  final String currency;
  final String cyrrent;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final active = currency == cyrrent;

    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: active
            ? null
            : () {
                onPressed(currency);
              },
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              currency,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
            const Spacer(),
            active
                ? SvgWidget(
                    Assets.check,
                    color: colors.accent,
                  )
                : const SizedBox(),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
