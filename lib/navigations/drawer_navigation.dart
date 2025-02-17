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
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/manage_projects");
            },
          ),
          _buildItems(
            icon: Icons.task_alt_outlined,
            title: "Tasks",
            onTap: () { 
              Navigator.pop(context);
              Navigator.pushNamed(context, "/manage_tasks");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple),
      child: Column(
        children: [
          Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24))]
      ),
    );
  }

  Widget _buildItems({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple), 
      title: Text(title), 
      onTap: onTap);
  }
}
