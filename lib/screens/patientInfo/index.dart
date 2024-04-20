import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralPatientInformationScreen extends StatefulWidget {
  const GeneralPatientInformationScreen({Key? key}) : super(key: key);

  @override
  _GeneralPatientInformationScreenState createState() =>
      _GeneralPatientInformationScreenState();
}

class _GeneralPatientInformationScreenState
    extends State<GeneralPatientInformationScreen> {
  Map<String, dynamic> patientData = {};

  @override
  void initState() {
    super.initState();
    getPatientInformation();
  }

  Future<void> getPatientInformation() async {
    CollectionReference patientsCollection =
        FirebaseFirestore.instance.collection('patients');
    DocumentSnapshot patientSnapshot =
        await patientsCollection.doc("3ynenDeXwfQ7uZdlQjSfmoAU6CP2").get();
    if (patientSnapshot.exists) {
      setState(() {
        patientData = patientSnapshot.data() as Map<String, dynamic>;
      });
    } else {
      print("Patient document does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information'),
      ),
      body: patientData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${patientData['name'] ?? ''}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email: ${patientData['email'] ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: ${patientData['phone'] ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address: ${patientData['address'] ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'User: ${patientData['user'] ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}
