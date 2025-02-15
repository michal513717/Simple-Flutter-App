import 'package:flutter/material.dart';
import '../navigations/drawer_navigation.dart';
import '../navigations/tab_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Time Tracking'),
          bottom: const TabNavigation(),
        ),
        drawer: const DrawerNavigation(),
      )
    );
  }
}