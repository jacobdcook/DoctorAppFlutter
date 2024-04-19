import 'package:flutter/material.dart';

class PrescriptionTrackerScreen extends StatefulWidget {
  const PrescriptionTrackerScreen({Key? key}) : super(key: key);

  @override
  _PrescriptionTrackerScreenState createState() =>
      _PrescriptionTrackerScreenState();
}

class _PrescriptionTrackerScreenState extends State<PrescriptionTrackerScreen> {
  List<Map<String, dynamic>> prescriptions = [
    {
      'name': 'Paracetamol',
      'dosage': '500mg, twice daily',
      'startDate': '2023-04-01',
      'endDate': '2023-04-15',
    },
    {
      'name': 'Amoxicillin',
      'dosage': '500mg, three times daily',
      'startDate': '2023-03-20',
      'endDate': '2023-04-03',
    },
    // Add more prescription entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Tracker'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          final prescription = prescriptions[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prescription['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dosage: ${prescription['dosage']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start Date: ${prescription['startDate']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'End Date: ${prescription['endDate']}',
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
