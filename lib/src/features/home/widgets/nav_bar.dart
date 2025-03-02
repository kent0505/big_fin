import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../../../core/config/constants.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70 + MediaQuery.of(context).viewPadding.bottom,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 8),
        decoration: const BoxDecoration(color: Color(0xff121212)),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavBarButton(
                  id: 1,
                  title: 'Home',
                  asset: Assets.tab1,
                  active: state is HomeInitial,
                ),
                _NavBarButton(
                  id: 2,
                  title: 'Analytics',
                  asset: Assets.tab2,
                  active: state is HomeAnalytics,
                ),
                _NavBarButton(
                  id: 3,
                  title: 'AI Assistant',
                  asset: Assets.tab3,
                  active: state is HomeAssistant,
                ),
                _NavBarButton(
                  id: 4,
                  title: 'Utilities',
                  asset: Assets.tab4,
                  active: state is HomeUtilities,
                ),
                _NavBarButton(
                  id: 5,
                  title: 'Settings',
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
    return Button(
      onPressed: active
          ? null
          : () {
              context.read<HomeBloc>().add(ChangeHome(id: id));
            },
      padding: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? Color(0xff1A382A) : null,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 44,
        width: active ? 108 : 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgWidget(
              asset,
              color: active ? Color(0xff41FDA9) : Color(0xff485C53),
            ),
            if (active) ...[
              SizedBox(width: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff41FDA9),
                  fontSize: 12,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
