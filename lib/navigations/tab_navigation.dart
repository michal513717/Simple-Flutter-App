import 'package:flutter/material.dart';

class TabNavigation extends StatelessWidget implements PreferredSizeWidget{
  const TabNavigation({ super.key });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: "All Entries"),
        Tab(text: "Grouped by Projects"),
      ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}