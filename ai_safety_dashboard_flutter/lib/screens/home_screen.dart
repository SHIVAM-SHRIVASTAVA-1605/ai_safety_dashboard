import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/incident_model.dart';
import '../providers/incident_provider.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/incident_card_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Incident> allIncidents = [];
  List<Incident> filteredIncidents = [];
  TextEditingController searchController = TextEditingController();
  String severityFilter = 'All';
  String dateFilter = '';

  @override
  void initState() {
    super.initState();
    allIncidents =
        Provider.of<IncidentProvider>(context, listen: false).incidents;
    filteredIncidents = List.from(allIncidents.reversed); // Show latest on top
    searchController.addListener(() {
      filterIncidents();
    });
  }

  void filterIncidents() {
    setState(() {
      filteredIncidents = allIncidents
          .where((incident) {
            bool matchesSearch = incident.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase());
            bool matchesSeverity =
                severityFilter == 'All' || incident.severity == severityFilter;
            bool matchesDate =
                dateFilter.isEmpty || incident.date.contains(dateFilter);
            return matchesSearch && matchesSeverity && matchesDate;
          })
          .toList(); // Reverse after filter
    });
  }

  @override
  Widget build(BuildContext context) {
    allIncidents = Provider.of<IncidentProvider>(context).incidents;
    filteredIncidents = allIncidents
        .where((incident) {
          bool matchesSearch = incident.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
          bool matchesSeverity =
              severityFilter == 'All' || incident.severity == severityFilter;
          bool matchesDate =
              dateFilter.isEmpty || incident.date.contains(dateFilter);
          return matchesSearch && matchesSeverity && matchesDate;
        })
        .toList()
        .reversed
        .toList(); // Reverse for latest first

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // 👈 Set your favorite color
        centerTitle: true, // 👈 Center the "Home Screen" text
        title: Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search by title...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Filter options code
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.blue[50], // Light background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Center(
                          child: Text(
                            'Filter Options',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButtonFormField<String>(
                                value: severityFilter,
                                decoration: InputDecoration(
                                  labelText: "Severity",
                                  prefixIcon: Icon(Icons.warning_amber),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                items: ['All', 'Low', 'Medium', 'High', 'Critical']
                                    .map((severity) => DropdownMenuItem(
                                          child: Text(severity),
                                          value: severity,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    severityFilter = value!;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Enter Date (yyyy-mm-dd)",
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onChanged: (value) {
                                  dateFilter = value;
                                },
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      filterIncidents();
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.check),
                                    label: Text('Apply'),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        severityFilter = 'All';
                                        dateFilter = '';
                                        filterIncidents();
                                      });
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.clear),
                                    label: Text('Clear'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredIncidents.isEmpty
                ? Center(child: Text('No incidents found'))
                : ListView.builder(
                    itemCount: filteredIncidents.length,
                    itemBuilder: (context, index) {
                      return IncidentCard(incident: filteredIncidents[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-incident');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
