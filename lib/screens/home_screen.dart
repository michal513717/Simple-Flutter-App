import 'package:flutter/material.dart';
import 'package:sfa/screens/add_time_entry_screen.dart';
import '../navigations/drawer_navigation.dart';
import '../navigations/tab_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Time Tracking'),
          bottom: const TabNavigation(),
        ),
        drawer: const DrawerNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
          ),
          tooltip: 'Add Time Entry',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}