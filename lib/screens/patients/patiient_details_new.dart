import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/screens/patients/patient_details_screen.dart';
import 'package:doctorapp/screens/patients/patients_screen.dart';
import 'package:flutter/material.dart';

class NewPatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? patient;

  const NewPatientDetailsScreen({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientDetailsScreen(patient: patient)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('${patient?['fName']} ${patient?['mName']} ${patient?['lName']}', style: TextStyle(
              fontSize: 32,
            ),),
            SizedBox(height: 8),
            Text('Day', style: TextStyle(
              fontSize: 18,
            )),
            SizedBox(height: 8),
            Text('Date 14/05/2024', style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 8),
            Text('Time 17:44:06', style: TextStyle(
              fontSize: 18,
            ),),
            SizedBox(height: 64),
            vitals(),
            info(),
          ],
        ),
      ),
    );
  }

  Widget vitals() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').doc("${patient?['fName']}${patient?['mName']}${patient?['lName']}").collection('vitals').snapshots(),
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
              child: Text('N/A'),
            );
          }

          return ListView.builder(
            itemCount: subcollectionSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var documentData = subcollectionSnapshot.data!.docs[index].data();
              var id = subcollectionSnapshot.data!.docs[index].id;
              // Display document data from the subcollection
              return Card(
                elevation: 2, // Adjust the elevation as needed
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust the margin as needed
                child: ListTile(
                  title: Text(id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  subtitle: Text( "${(documentData as Map<String, dynamic>)['info']} ${(documentData as Map<String, dynamic>)['unit']}" ?? '', style: TextStyle(fontSize: 16,),),
                ),
              );
            },
          );

        },
      ),
    );
  }

  Widget info() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').doc("${patient?['fName']}${patient?['mName']}${patient?['lName']}").collection('PatientAppointmentInfo').snapshots(),
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
              child: Text('N/A'),
            );
          }

          return ListView.builder(
            itemCount: subcollectionSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var documentData = subcollectionSnapshot.data!.docs[index].data();
              var id = subcollectionSnapshot.data!.docs[index].id;
              // Display document data from the subcollection
              return Card(
                elevation: 2, // Adjust the elevation as needed
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust the margin as needed
                child: ListTile(
                  title: Text(id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  subtitle: Text( "${(documentData as Map<String, dynamic>)['info']}" ?? '', style: TextStyle(fontSize: 16,),),
                ),
              );
            },
          );

        },
      ),
    );
  }

}

