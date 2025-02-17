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
    var storedTasks = storage.getItem('tasks');
    if(storedTasks != null){
      _tasks = List<Task>.from(
        (storedTasks as List).map((item) => Task.fromJson(item)),
      );
       ();
    }
  }

  void _saveTasksToStorage() {
    String jsonString = jsonEncode(_tasks.map((e) => e.toJson()).toList());
    storage.setItem('tasks', jsonString);
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void addTask(Task data) {
    _tasks.add(data);
    _saveTasksToStorage();
    notifyListeners();
  }
}