import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import '../models/time_entry.model.dart';
import 'dart:convert';

class TimeEntryProvider with ChangeNotifier {
  LocalStorage storage;
  List<TimeEntry> _timeEntries = [];

  List<TimeEntry> get timeEntry => _timeEntries;

  TimeEntryProvider(this.storage){
    _loadTimeEntriesFromStorage();
  }

  void _loadTimeEntriesFromStorage() async {
    var storedTimeEntries = storage.getItem('timeEntries');
    
    if(storedTimeEntries != null){
      List<dynamic> decodedEntries;
      decodedEntries = jsonDecode(storedTimeEntries);
      _timeEntries = decodedEntries.map((item) => TimeEntry.fromJson(item)).toList();
    }
  }

  void _saveTimeEntriesToStorage() {
    String jsonString = jsonEncode(_timeEntries.map((e) => e.toJson()).toList());
    storage.setItem('timeEntries', jsonString);
  }

  void addTimeEntry(TimeEntry data) {
    _timeEntries.add(data);
    _saveTimeEntriesToStorage();
    notifyListeners();
  }
}