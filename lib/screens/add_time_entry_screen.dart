import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../models/time_entry.model.dart';
import './../providers/time_entry_provider.dart';

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  State<AddTimeEntryScreen> createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _projectId = '';
  String _taskId = '';
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
        padding: const EdgeInsets.all(16.0), // Padding wokół całego formularza
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _projectId.isEmpty ? null : _projectId,
                onChanged: (String? newValue) {
                  setState(() {
                    _projectId = newValue ?? '';
                  });
                },
                decoration: const InputDecoration(labelText: 'Project'),
                items: ['Project 1', 'Project 2', 'Project 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16), // Odstęp

              DropdownButtonFormField<String>(
                value: _taskId.isEmpty ? null : _taskId,
                onChanged: (String? newValue) {
                  setState(() {
                    _taskId = newValue ?? '';
                  });
                },
                decoration: const InputDecoration(labelText: 'Task'),
                items: ['Task 1', 'Task 2', 'Task 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16), // Odstęp

              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: "${_selectedDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Odstęp

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
              const SizedBox(height: 16), // Odstęp

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
              const SizedBox(height: 24), // Większy odstęp przed przyciskiem

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
                          id: DateTime.now().toString(), // Simple ID generation
                          projectId: _projectId,
                          taskId: _taskId,
                          totalTime: _totalTime,
                          date: _selectedDate, // Używa wybranej daty
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
