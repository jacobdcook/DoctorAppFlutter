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
            SizedBox(height: 8),
            Text('First Name: ${patient?['fName'] ?? ''}'),
            SizedBox(height: 8),
            Text('Middle Name: ${patient?['mName'] ?? ''}'),
            SizedBox(height: 8),
            Text('Last Name: ${patient?['lName'] ?? ''}'),
            SizedBox(height: 8),
            Text('Date of Birth: ${patient?['dOB'] ?? ''}'),
            SizedBox(height: 8),
            Text('Blood Group: ${patient?['bloodGroup'] ?? ''}'),
            SizedBox(height: 8),
            Text('RH Factor: ${patient?['rHFactor'] ?? ''}'),
            SizedBox(height: 8),
            Text('Marital Status: ${patient?['maritalStatus'] ?? ''}'),
            SizedBox(height: 8),
            Text('Age: ${patient?['age'] ?? ''}'),
            SizedBox(height: 8),
            Text('Phone Residence: ${patient?['phoneResidence'] ?? ''}'),
            SizedBox(height: 8),
            Text('Phone Number: ${patient?['phone'] ?? ''}'),
            SizedBox(height: 8),
            Text('Email: ${patient?['email'] ?? ''}'),
            SizedBox(height: 8),
            Text('Emergency Contact: ${patient?['eCName'] ?? ''}'),
            SizedBox(height: 8),
            Text('Emergency Contact Phone: ${patient?['eCPhone'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}
