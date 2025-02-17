import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfa/models/project.model.dart';
import 'package:sfa/providers/project_provider.dart';
import 'package:sfa/providers/time_entry_provider.dart';
import 'package:sfa/screens/add_time_entry_screen.dart';
import 'package:sfa/navigations/drawer_navigation.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[800],
          foregroundColor: Colors.white,
          title: const Text('Time Tracking'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: "All Entries"), Tab(text: "Grouped by Projects")],
          ),
        ),
        drawer: const DrawerNavigation(),
        body: TabBarView(
          controller: _tabController,
          children: [buildByAllEntries(context)],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
              ),
          tooltip: 'Add Time Entry',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildByAllEntries(BuildContext context) {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.timeEntries.length,
          itemBuilder: (context, index) {
            final entry = provider.timeEntries[index];
            return Dismissible(
              key: Key(entry.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => {provider.removeTimeEntry(entry.id)},
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Teksty w kolumnie
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry.projectId} - ${entry.taskId}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Total Time: ${entry.totalTime} hours",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Date: ${DateFormat('MMM dd, yyyy').format(entry.date)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Note: ${entry.notes}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String getProjectNameById(BuildContext context, String projectId) {
    var projectProvider = Provider.of<ProjectProvider>(context, listen: false);
    var project = projectProvider.projects.firstWhere(
      (proj) => proj.id == projectId,
      orElse: () => Project(id: "", name: "Unknown Project"),
    );
    return project.name;
  }
}
