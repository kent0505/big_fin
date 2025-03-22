import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/language_bloc.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const routePath = '/LanguageScreen';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(title: l.language),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          const _LanguageButton(
            title: 'English',
            locale: Locales.defaultLocale,
          ),
          const _LanguageButton(
            title: 'Русский',
            locale: Locales.ru,
          ),
          const _LanguageButton(
            title: 'Español',
            locale: Locales.es,
          ),
          const _LanguageButton(
            title: 'Deutsch',
            locale: Locales.de,
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.title,
    required this.locale,
  });

  final String title;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final current = context.watch<LanguageBloc>().state.languageCode;

    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: current == locale
            ? null
            : () {
                context.read<LanguageBloc>().add(SetLanguage(locale: locale));
              },
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
            const Spacer(),
            BlocBuilder<LanguageBloc, Locale>(
              builder: (context, state) {
                return locale == state.languageCode
                    ? SvgWidget(
                        Assets.check,
                        color: colors.accent,
                      )
                    : const SizedBox();
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
