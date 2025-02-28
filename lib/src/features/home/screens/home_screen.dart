import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../analytics/screens/analytics_screen.dart';
import '../../assistant/screens/assistant_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../utilities/screens/utilities_screen.dart';
import '../blocs/navbar/navbar_bloc.dart';
import '../widgets/nav_bar.dart';
import 'first_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 70 + MediaQuery.of(context).viewPadding.bottom,
            ),
            child: BlocConsumer<NavbarBloc, NavbarState>(
              listener: (context, state) {
                logger(state.runtimeType);
              },
              builder: (context, state) {
                if (state is NavbarAnalytics) return const AnalyticsScreen();
                if (state is NavbarAssistant) return const AssistantScreen();
                if (state is NavbarUtilities) return const UtilitiesScreen();
                if (state is NavbarSettings) return const SettingsScreen();

                return const FirstScreen();
              },
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
