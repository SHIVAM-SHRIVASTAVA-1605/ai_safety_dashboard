class Incident {
  final String title;
  final String description;
  final String severity;
  final String date;

  Incident({
    required this.title,
    required this.description,
    required this.severity,
    required this.date,
  });

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      title: map['title'],
      description: map['description'],
      severity: map['severity'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'severity': severity,
      'date': date,
    };
  }
}
