import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfa/widgets/add_project_dialog.dart';
import 'package:sfa/providers/project_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  const ProjectTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Projects')),
      body: Consumer<ProjectProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.projects.length,
            itemBuilder: (context, index) {
              final project = provider.projects[index];
              return ListTile(
                title: Text(project.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteProject(project.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                ((context) => AddProjectDialog(
                  onAdd: (newProject) {
                    Provider.of<ProjectProvider>(
                      context,
                      listen: false,
                    ).addProject(newProject);
                    Navigator.pop(context);
                  },
                )),
          );
        },
        tooltip: 'Add Project',
        child: Icon(Icons.add),
      ),
    );
  }
}
