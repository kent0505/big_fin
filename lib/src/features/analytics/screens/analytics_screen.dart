import 'package:flutter/material.dart';

import '../../../core/widgets/tab_widget.dart';
import 'select_time_periodic.dart';


/// {@template analytics_screen}
/// AnalyticsScreen widget.
/// {@endtemplate}
class AnalyticsScreen extends StatefulWidget {
  /// {@macro analytics_screen}
  const AnalyticsScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

/// State for widget AnalyticsScreen.
class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late final ValueNotifier<int> _timePeriodNotifer;
  /* #region Lifecycle */
  @override
  void initState() {
    _timePeriodNotifer = ValueNotifier(0);
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant AnalyticsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _timePeriodNotifer,
        builder: (context, timePeriodIndex, child) {
          return Column(
            children: [
              TabWidget(
                titles: ['Week', 'Month', 'Year', 'Custom'],
                onTap: (index) {},
              ),
              Expanded(
                child:
                    SelectTimePeriodicWidget(timePeriodIndex: timePeriodIndex),
              ),
            ],
          );
        });
  }
}

