import 'package:flutter/material.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildHeader(),
          _buildItems(
            icon: Icons.folder,
            title: "Projects",
            onTap: () => Navigator.pushNamed(context, "Projects"),
          ),
          _buildItems(
            icon: Icons.task,
            title: "Tasks",
            onTap: () => Navigator.pushNamed(context, "Tasks"),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Color(0xff1D1E22)),
      child: Column(children: [Text("Menu")]),
    );
  }

  Widget _buildItems({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
