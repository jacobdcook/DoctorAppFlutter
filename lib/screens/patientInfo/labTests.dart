import 'package:flutter/material.dart';

class LabTestsScreen extends StatefulWidget {
  const LabTestsScreen({Key? key}) : super(key: key);

  @override
  _LabTestsScreenState createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends State<LabTestsScreen> {
  List<Map<String, dynamic>> labTests = [
    {
      'title': 'Blood Test',
      'date': '2023-04-01',
      'results': 'Normal',
    },
    {
      'title': 'X-Ray (Chest)',
      'date': '2022-09-15',
      'results': 'No abnormalities detected',
    },
    // Add more lab test entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Tests'),
      ),
      body: ListView.builder(
        itemCount: labTests.length,
        itemBuilder: (context, index) {
          final test = labTests[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${test['date']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Results: ${test['results']}',
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
