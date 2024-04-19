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
  late Map<String, dynamic> patientData;

  @override
  void initState() {
    super.initState();
    getPatientInformation();
  }

  Future<void> getPatientInformation() async {
    CollectionReference patientsCollection =
        FirebaseFirestore.instance.collection('patients');

    // Replace "111222333" with the actual patient ID you want to retrieve
    DocumentSnapshot patientSnapshot =
        await patientsCollection.doc("111222333").get();

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
                  Text('First Name: ${patientData['fName']}'),
                  Text('Last Name: ${patientData['lName']}'),
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}
