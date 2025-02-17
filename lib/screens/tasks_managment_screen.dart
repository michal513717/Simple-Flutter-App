import 'package:sfa/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfa/widgets/add_task_dialog.dart';

class TasksManagmentScreen extends StatelessWidget {
  const TasksManagmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Tasks"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,  
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    provider.deleteTask(task.id);
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
                (context) => AddTaskDialog(
                  onAdd: (newTask) {
                    Provider.of<TaskProvider>(
                      context,
                      listen: false,
                    ).addTask(newTask);
                    Navigator.pop(context);
                  },
                ),
          );
        },
        tooltip: 'Add new task',
        child: Icon(Icons.add),
      ),
    );
  }
}
