import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:sfa/models/project.model.dart';
import 'dart:convert';

class ProjectProvider with ChangeNotifier {
  LocalStorage storage;
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  ProjectProvider(this.storage) {
    _loadProjectFromStorage();
  }

  void _loadProjectFromStorage() async {
    var storeProjects = storage.getItem('projects-v1');

    if (storeProjects != null) {
      List<dynamic> decodedProcjects;
      decodedProcjects = jsonDecode(storeProjects);
      _projects = decodedProcjects.map((item) => Project.fromJson(item)).toList();
    }
  }

  void _saveProjectsToStorage() {
    String jsonString = jsonEncode(_projects.map((e) => e.toJson()).toList());
    storage.setItem('projects-v1', jsonString);
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _saveProjectsToStorage();
    notifyListeners();
  }

  void addProject(Project data) {
    _projects.add(data);
    _saveProjectsToStorage();
    notifyListeners();
  }
}
