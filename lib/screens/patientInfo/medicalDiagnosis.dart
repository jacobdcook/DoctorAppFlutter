import 'package:flutter/material.dart';

class MedicalDiagnosisScreen extends StatefulWidget {
  const MedicalDiagnosisScreen({Key? key}) : super(key: key);

  @override
  _MedicalDiagnosisScreenState createState() => _MedicalDiagnosisScreenState();
}

class _MedicalDiagnosisScreenState extends State<MedicalDiagnosisScreen> {
  List<Map<String, dynamic>> diagnosis = [
    {
      'title': 'Asthma',
      'date': '2021-03-10',
      'details': 'Diagnosed with mild asthma. Prescribed inhaler.',
    },
    {
      'title': 'Gastritis',
      'date': '2022-11-25',
      'details':
          'Suffered from severe gastritis. Prescribed medication and diet plan.',
    },
    // Add more diagnosis entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Diagnosis'),
      ),
      body: ListView.builder(
        itemCount: diagnosis.length,
        itemBuilder: (context, index) {
          final entry = diagnosis[index];
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
