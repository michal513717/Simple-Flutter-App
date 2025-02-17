import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import '../models/task.model.dart';
import 'dart:convert';

class TaskProvider with ChangeNotifier {
  LocalStorage storage;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider(this.storage){
    _loadTasksFromStorage();
  }

  void _loadTasksFromStorage() async {
    var storedTasks = storage.getItem('tasks-v1');

    if(storedTasks != null){
      List<dynamic> decodedTasks;
      decodedTasks = jsonDecode(storedTasks);
      _tasks = decodedTasks.map((item) => Task.fromJson(item)).toList();
    }
  }

  void _saveTasksToStorage() {
    String jsonString = jsonEncode(_tasks.map((e) => e.toJson()).toList());
    storage.setItem('tasks-v1', jsonString);
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasksToStorage();
    notifyListeners();
  }

  void addTask(Task data) {
    _tasks.add(data);
    _saveTasksToStorage();
    notifyListeners();
  }
}