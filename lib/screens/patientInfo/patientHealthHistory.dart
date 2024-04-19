import 'package:flutter/material.dart';

class PatientHealthHistoryScreen extends StatefulWidget {
  const PatientHealthHistoryScreen({Key? key}) : super(key: key);

  @override
  _PatientHealthHistoryScreenState createState() =>
      _PatientHealthHistoryScreenState();
}

class _PatientHealthHistoryScreenState
    extends State<PatientHealthHistoryScreen> {
  List<Map<String, dynamic>> healthHistory = [
    {
      'title': 'Appendicitis',
      'date': '2022-05-15',
      'details': 'Underwent appendectomy at City Hospital.',
    },
    {
      'title': 'Flu',
      'date': '2023-02-01',
      'details': 'Suffered from severe flu symptoms for a week.',
    },
    // Add more health history entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Health History'),
      ),
      body: ListView.builder(
        itemCount: healthHistory.length,
        itemBuilder: (context, index) {
          final entry = healthHistory[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${entry['date']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Details: ${entry['details']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
