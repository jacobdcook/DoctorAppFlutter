import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? patient;

  const PatientDetailsScreen({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${patient?['name'] ?? ''}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Email: ${patient?['email'] ?? ''}'),
            SizedBox(height: 8),
            Text('Phone: ${patient?['phone'] ?? ''}'),
            SizedBox(height: 8),
            Text('Address: ${patient?['address'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}
