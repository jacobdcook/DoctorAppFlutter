import 'package:flutter/material.dart';

class PatientFamilyTrackerScreen extends StatefulWidget {
  const PatientFamilyTrackerScreen({Key? key}) : super(key: key);

  @override
  _PatientFamilyTrackerScreenState createState() =>
      _PatientFamilyTrackerScreenState();
}

class _PatientFamilyTrackerScreenState
    extends State<PatientFamilyTrackerScreen> {
  List<Map<String, dynamic>> familyMembers = [
    {
      'name': 'John Doe',
      'relation': 'Father',
      'medicalHistory': 'Diabetes, High Blood Pressure',
    },
    {
      'name': 'Jane Doe',
      'relation': 'Mother',
      'medicalHistory': 'Breast Cancer',
    },
    // Add more family members here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Family Tracker'),
      ),
      body: ListView.builder(
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Relation: ${member['relation']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Medical History: ${member['medicalHistory']}',
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
