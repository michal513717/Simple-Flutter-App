import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import '../models/project.model.dart';
import 'dart:convert';

class ProjectProvider with ChangeNotifier {
  LocalStorage storage;
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  ProjectProvider(this.storage){
    _loadProjectFromStorage();
  }

  void _loadProjectFromStorage() async {
    var storedTasks = storage.getItem('projects');
    if(storedTasks != null){
      _projects = List<Project>.from(
        (storedTasks as List).map((item) => Project.fromJson(item)),
      );
       ();
    }
  }

  void _saveProjectsToStorage() {
    String jsonString = jsonEncode(_projects.map((e) => e.toJson()).toList());
    storage.setItem('projects', jsonString);
  }

  void deleteProject(String id){
    _projects.removeWhere((project) => project.id == id);
    notifyListeners();
  }

  void addProject(Project data) {
    _projects.add(data);
    _saveProjectsToStorage();
    notifyListeners();
  }
}