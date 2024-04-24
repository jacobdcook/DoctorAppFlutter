import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/screens/patientInfo/prescriptionTracker.dart';
import 'package:flutter/material.dart';

// From this screen, the user will click on a patient's name and be takin to prescriptionTracker.dart

class SearchPrescriptionTrackerScreen extends StatefulWidget {
  const SearchPrescriptionTrackerScreen({Key? key}) : super(key: key);

  @override
  _SearchPrescriptionTrackerScreenState createState() =>_SearchPrescriptionTrackerScreenState();
}

class _SearchPrescriptionTrackerScreenState extends State<SearchPrescriptionTrackerScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search patients',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('patients').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final patients = snapshot.data!.docs;
                  final filteredPatients = patients.where((patient) {
                    final patientName = patient['fName']?.toLowerCase() ?? '';
                    return patientName.contains(_searchQuery.toLowerCase());
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = filteredPatients[index].data()
                          as Map<String, dynamic>?;
                      final patientName = "${patient?['fName']} ${patient?['mName']} ${patient?['lName']}";
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                PrescriptionTrackerScreen(patient: patient),
                            ),
                          );
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            patientName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]
      ),
    );
  }
}