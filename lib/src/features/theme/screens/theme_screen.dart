import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/theme_bloc.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  static const routePath = '/ThemeScreen';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(title: l.theme),
      body: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ThemeButton(
                title: l.deviceTheme,
                active: state == ThemeMode.system,
                onPressed: () {
                  context.read<ThemeBloc>().add(SetTheme(id: 0));
                },
              ),
              _ThemeButton(
                title: l.light,
                active: state == ThemeMode.light,
                onPressed: () {
                  context.read<ThemeBloc>().add(SetTheme(id: 1));
                },
              ),
              _ThemeButton(
                title: l.dark,
                active: state == ThemeMode.dark,
                onPressed: () {
                  context.read<ThemeBloc>().add(SetTheme(id: 2));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            if (active)
              SizedBox(
                width: 24,
                child: SvgWidget(
                  Assets.check,
                  color: colors.accent,
                ),
              ),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}
