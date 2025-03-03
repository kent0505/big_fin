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
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: Appbar(title: l.language),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _LanguageButton(title: 'English', locale: 'en'),
          _LanguageButton(title: 'Русский', locale: 'ru'),
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

    return Container(
      height: 52,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.read<LanguageBloc>().add(SetLanguage(locale: locale));
        },
        child: Row(
          children: [
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
            Spacer(),
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return state is LanguageInitial && state.locale == locale
                    ? SvgWidget(
                        Assets.check,
                        color: colors.accent,
                      )
                    : SizedBox();
              },
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
