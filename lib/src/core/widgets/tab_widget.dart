import 'package:flutter/material.dart';

import '../config/constants.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.pages,
    required this.titles,
  });

  final List<Widget> pages;
  final List<String> titles;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController.index;
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20 + MediaQuery.of(context).viewPadding.top),
        // Container(
        //   height: 46,
        //   // color: Colors.redAccent,
        //   margin: const EdgeInsets.symmetric(horizontal: 0),
        //   child: TabBar(
        //     controller: _tabController,
        //     indicatorColor: Colors.transparent,
        //     overlayColor: WidgetStateProperty.all(Colors.transparent),
        //     tabs: List.generate(
        //       widget.titles.length,
        //       (index) {
        //         return _Tab(
        //           title: widget.titles[index],
        //           isSelected: _selectedIndex == index,
        //         );
        //       },
        //     ),
        //   ),
        // ),
        Container(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 26),
          child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 5.0,
                color: AppColors.main,
              ),
            ),
            overlayColor: WidgetStateProperty.all(
              Colors.transparent, // splash color removed
            ),
            tabs: widget.titles.map((title) => _Tab(title)).toList(),
          ),
        ),
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

class _Tab extends StatelessWidget {
  const _Tab(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.main,
          fontSize: 20,
          fontFamily: 'w400',
        ),
      ),
    );
  }
}

// class _Tab extends StatelessWidget {
//   const _Tab({
//     required this.title,
//     required this.isSelected,
//   });

//   final String title;
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30,
//       width: 70,
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white : Colors.transparent,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Center(
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Color(0xff333333),
//             fontSize: 18,
//             fontFamily: Fonts.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
