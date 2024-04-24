import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/screens/patientInfo/addPrescription.dart';
import 'package:flutter/material.dart';

class PrescriptionTrackerScreen extends StatelessWidget {
  final Map<String, dynamic>? patient;  // Holds the selected patient
  const PrescriptionTrackerScreen({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPrescriptionScreen(patient: patient)),
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
          listOfPrescriptions(),
        ],
      )
    );
  }

  Widget listOfPrescriptions() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').doc("${patient?['fName']}${patient?['mName']}${patient?['lName']}").collection('prescriptions').snapshots(),
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
              child: Text('No previous prescriptions'),
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
                  title: Text("${(documentData as Map<String, dynamic>)['title']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dosage : ${(documentData as Map<String, dynamic>)['dosage']}", style: TextStyle(fontSize: 16,),),
                      Text("Start Date: ${(documentData as Map<String, dynamic>)['startDate']}", style: TextStyle(fontSize: 16,),),
                      Text("End Date: ${(documentData as Map<String, dynamic>)['endDate']}", style: TextStyle(fontSize: 16,),),
                    ],
                  ),
                ),
              );
            },
          );

        },
      ),
    );
  }

}

