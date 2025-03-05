import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.tabs});

  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: tabs
            .map(
              (tab) => _Tab(tab: tab),
            )
            .toList(),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.tab});

  final TabItem tab;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tab.active ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Button(
          onPressed: tab.onPressed,
          child: Center(
            child: Text(
              tab.title,
              style: TextStyle(
                color: tab.active ? Colors.black : colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabItem {
  TabItem({
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;
}
