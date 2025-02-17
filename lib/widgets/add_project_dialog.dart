import 'package:flutter/material.dart';
import 'package:sfa/models/project.model.dart';

class AddProjectDialog extends StatefulWidget {

  const AddProjectDialog({required this.onAdd, super.key});

  final Function(Project) onAdd;

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Project'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Project',
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
            var newCategory = Project(
                id: DateTime.now().toString(), name: _controller.text);
            widget.onAdd(newCategory);

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