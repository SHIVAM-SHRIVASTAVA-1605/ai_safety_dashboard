import 'package:flutter/material.dart';
import '../models/incident_model.dart';

class EditIncidentScreen extends StatefulWidget {
  final Incident incident;

  EditIncidentScreen({required this.incident});

  @override
  _EditIncidentScreenState createState() => _EditIncidentScreenState();
}

class _EditIncidentScreenState extends State<EditIncidentScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String? selectedSeverity;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.incident.title);
    descriptionController =
        TextEditingController(text: widget.incident.description);
    selectedSeverity = widget.incident.severity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Edit Incident'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedSeverity,
                decoration: InputDecoration(
                  labelText: "Severity",
                  border: OutlineInputBorder(),
                ),
                items: ['Low', 'Medium', 'High', 'Critical']
                    .map((severity) => DropdownMenuItem(
                          child: Text(severity),
                          value: severity,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSeverity = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Make sure to pass the correct index of the incident (stored in widget.index)
                   Navigator.pop(context); // Close the screen after the update
                },
                child: Text('Save Changes'),
              )
            ],
          ),
        ),
      ),
    );
  }
}