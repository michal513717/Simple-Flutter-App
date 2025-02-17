import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfa/models/task.model.dart';
import 'package:sfa/providers/task_provider.dart';

class AddTaskDialog extends StatefulWidget {

  const AddTaskDialog({required this.onAdd, super.key});

  final Function(Task) onAdd;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Task',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            var newCategory = Task(
                id: DateTime.now().toString(), name: _controller.text);
            widget.onAdd(newCategory);
            Provider.of<TaskProvider>(context, listen: false)
                .addTask(newCategory);
            _controller.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}