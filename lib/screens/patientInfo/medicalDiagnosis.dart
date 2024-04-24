import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/screens/patientInfo/addDiagnosis.dart';
import 'package:flutter/material.dart';

class MedicalDiagnosisScreen extends StatelessWidget {
  final Map<String, dynamic>? patient;  // Holds the selected patient
  const MedicalDiagnosisScreen({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Diagnosis'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddDiagnosisScreen(patient: patient)),
              );
            },
          ),
        ],
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("${patient?['fName']} ${patient?['mName']} ${patient?['lName']}",
              style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold ),
            ),
          ),
          listOfDiagnoses(),
        ],
      )
    );
  }

  Widget listOfDiagnoses() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').doc("${patient?['fName']}${patient?['mName']}${patient?['lName']}").collection('medicalDiagnosis').snapshots(),
        builder: (context, subcollectionSnapshot) {
          if (subcollectionSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (subcollectionSnapshot.hasError) {
            return Center(
              child: Text('Error: ${subcollectionSnapshot.error}'),
            );
          }
          if (!subcollectionSnapshot.hasData || subcollectionSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No previous diagnoses'),
            );
          }

          return ListView.builder(
            itemCount: subcollectionSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var documentData = subcollectionSnapshot.data!.docs[index].data();
              // Display document data from the subcollection
              return Card(
                elevation: 2, // Adjust the elevation as needed
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust the margin as needed
                child: ListTile(
                  title: Text("${(documentData as Map<String, dynamic>)['title']} - ${(documentData as Map<String, dynamic>)['date']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  subtitle: Text( (documentData as Map<String, dynamic>)['details'] ?? '', style: TextStyle(fontSize: 16,),),
                ),
              );
            },
          );

        },
      ),
    );
  }

}

