import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfa/models/time_entry.model.dart';
import 'package:sfa/providers/time_entry_provider.dart';
import 'package:sfa/providers/project_provider.dart';
import 'package:sfa/providers/task_provider.dart';

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  State<AddTimeEntryScreen> createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _projectId;
  String? _taskId;
  double _totalTime = 0.0;
  String _notes = '';
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Time Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --------- PROJECT DROPDOWN (Consumer) ---------
              Consumer<ProjectProvider>(
                builder: (context, projectProvider, child) {
                  final projects = projectProvider.projects;
                  return DropdownButtonFormField<String>(
                    value: _projectId,
                    onChanged: (String? newValue) {
                      setState(() {
                        _projectId = newValue;
                        _taskId = null;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Project'),
                    items: projects.isNotEmpty
                        ? projects.map<DropdownMenuItem<String>>((project) {
                            return DropdownMenuItem<String>(
                              value: project.name,
                              child: Text(project.name),
                            );
                          }).toList()
                        : [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Brak projektów'),
                            )
                          ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // --------- TASK DROPDOWN (Consumer) ---------
              Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  final tasks = taskProvider.tasks;
                  return DropdownButtonFormField<String>(
                    value: _taskId,
                    onChanged: (String? newValue) {
                      setState(() {
                        _taskId = newValue;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Task'),
                    items: tasks.isNotEmpty
                        ? tasks.map<DropdownMenuItem<String>>((task) {
                            return DropdownMenuItem<String>(
                              value: task.name,
                              child: Text(task.name),
                            );
                          }).toList()
                        : [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Brak zadań'),
                            )
                          ],
                  );
                },
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: "${_selectedDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Time (hours)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total time';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _totalTime = double.tryParse(value!.replaceAll(',', '.')) ?? 0.0,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some notes';
                  }
                  return null;
                },
                onSaved: (value) => _notes = value!,
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Provider.of<TimeEntryProvider>(
                        context,
                        listen: false,
                      ).addTimeEntry(
                        TimeEntry(
                          id: DateTime.now().toString(),
                          projectId: _projectId!,
                          taskId: _taskId!,
                          totalTime: _totalTime,
                          date: _selectedDate,
                          notes: _notes,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text('Save', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
