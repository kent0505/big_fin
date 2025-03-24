import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/config/constants.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/button.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70 + MediaQuery.of(context).viewPadding.bottom,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ).copyWith(top: 8),
        decoration: BoxDecoration(color: colors.bg),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavBarButton(
                  id: 1,
                  title: l.home,
                  asset: Assets.tab1,
                  active: state is HomeInitial,
                ),
                _NavBarButton(
                  id: 2,
                  title: l.analytics,
                  asset: Assets.tab2,
                  active: state is HomeAnalytics,
                ),
                // if (isIOS())
                _NavBarButton(
                  id: 3,
                  title: l.assistant,
                  asset: Assets.tab3,
                  active: state is HomeAssistant,
                ),
                _NavBarButton(
                  id: 4,
                  title: l.utilities,
                  asset: Assets.tab4,
                  active: state is HomeUtilities,
                ),
                _NavBarButton(
                  id: 5,
                  title: l.settings,
                  asset: Assets.tab5,
                  active: state is HomeSettings,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.id,
    required this.title,
    required this.asset,
    required this.active,
  });

  final int id;
  final String title;
  final String asset;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    // final state = context.watch<VipBloc>().state;

    return Button(
      onPressed: active
          ? null
          : () {
              // if (id == 3 && state is VipsLoaded) {
              //   context.push(VipScreen.routePath);
              // } else {
              context.read<HomeBloc>().add(ChangeHome(id: id));
              // }
            },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: active ? colors.tertiaryTwo : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: 44,
          width: active ? 108 : 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              SvgWidget(
                asset,
                color: active ? colors.accent : colors.tertiaryThree,
              ),
              if (active) ...[
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 12,
                      fontFamily: AppFonts.bold,
                      height: 1,
                    ),
                  ),
                ),
              ],
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
