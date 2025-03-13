import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    required this.titles,
    this.pages = const [],
    this.onTap,
    super.key,
  });

  final List<Widget> pages;
  final List<String> titles;

  final void Function(int currentIndex)? onTap;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.titles.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        Container(
          height: 52,
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.tertiaryOne,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TabBar(
            onTap: widget.onTap,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:
                  _tabController.index == _selectedIndex ? colors.accent : null,
            ),
            indicatorWeight: 2,
            labelColor: Colors.black,
            unselectedLabelColor: colors.textPrimary,
            labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
            tabs: List.generate(
              widget.titles.length,
              (index) {
                return Tab(
                  text: widget.titles[index],
                );
              },
            ),
          ),
        ),
        if (widget.pages.isNotEmpty)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.pages,
            ),
          ),
      ],
    );
  }
}
