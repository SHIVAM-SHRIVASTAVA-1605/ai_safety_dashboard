import 'package:flutter/material.dart';
import '../models/incident_model.dart';

class IncidentProvider with ChangeNotifier {
  List<Incident> _incidents = [];
  String _selectedSeverity = 'All';
  DateTime _selectedDate = DateTime.now();

  List<Incident> get incidents => _incidents;
  String get selectedSeverity => _selectedSeverity;
  DateTime get selectedDate => _selectedDate;

  IncidentProvider() {
    _addDefaultIncidents(); // 👈 Add this line to call when provider initializes
  }

  void _addDefaultIncidents() {
    _incidents = [
      Incident(
        title: 'Server Downtime',
        description: 'Main server is down.',
        severity: 'Critical',
        date: DateTime.now().toString().substring(0, 10),
      ),
      Incident(
        title: 'Login Issue',
        description: 'Users are unable to login.',
        severity: 'High',
        date: DateTime.now().toString().substring(0, 10),
      ),
      Incident(
        title: 'Minor UI Bug',
        description: 'Button alignment is off.',
        severity: 'Medium',
        date: DateTime.now().toString().substring(0, 10),
      ),
      Incident(
        title: 'Typo in About Page',
        description: 'Spelling mistake in About Us page.',
        severity: 'Low',
        date: DateTime.now().toString().substring(0, 10),
      ),
    ];
  }

  void addIncident(Incident incident) {
    _incidents.insert(0, incident);
    notifyListeners();
  }

  void setSelectedSeverity(String severity) {
    _selectedSeverity = severity;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Incident> getFilteredIncidents() {
    return _incidents.where((incident) {
      bool matchesSeverity =
          _selectedSeverity == 'All' || incident.severity == _selectedSeverity;
      bool matchesDate =
          incident.date == _selectedDate.toString().substring(0, 10);
      return matchesSeverity && matchesDate;
    }).toList();
  }
}
