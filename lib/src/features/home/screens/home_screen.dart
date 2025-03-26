import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../analytics/screens/analytics_screen.dart';
import '../../assistant/screens/assistant_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../utils/screens/utils_screen.dart';
import '../../vip/bloc/bloc/vip_bloc.dart';
import '../../vip/screens/vip_screen.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_appbar.dart';
import '../widgets/nav_bar.dart';
import 'main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppbar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 70 + MediaQuery.of(context).viewPadding.bottom,
            ),
            child: BlocListener<VipBloc, VipState>(
              listener: (context, state) {
                // ПРИ КАЖДОМ ЗАХОДЕ ПОКАЗЫВАЕТ ПЕЙВОЛ
                if (state is VipsLoaded && state.showPaywall) {
                  VipSheet.show(context, timer: true);
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return MainScreen(
                      date: state.date,
                      cat: state.cat,
                    );
                  }

                  if (state is HomeAnalytics) return const AnalyticsScreen();
                  if (state is HomeAssistant) return const AssistantScreen();
                  if (state is HomeUtilities) return const UtilsScreen();

                  return const SettingsScreen();
                },
              ),
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
