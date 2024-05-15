// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define the PatientSelectionScreen class
class PatientSelectionScreen extends StatefulWidget {
  const PatientSelectionScreen({super.key});

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

// Define the _PatientsScreenState class
class _PatientsScreenState extends State<PatientSelectionScreen> {
  // Initialize the search query
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      // Set the body of the screen
      body: Column(
        children: [
          // Add a search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search patients',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Add a stream builder to display the patients
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Get the 'patients' collection from Firestore
              stream:
                  FirebaseFirestore.instance.collection('patients').snapshots(),
              builder: (context, snapshot) {
                // Check if the snapshot has data
                if (snapshot.hasData) {
                  // Get the list of patients
                  final patients = snapshot.data!.docs;
                  // Filter the patients based on the search query
                  final filteredPatients = patients.where((patient) {
                    final patientName = patient['fName']?.toLowerCase() ?? '';
                    return patientName.contains(_searchQuery.toLowerCase());
                  }).toList();
                  // Display the filtered patients in a ListView
                  return ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      // Get the patient data
                      final patient = filteredPatients[index].data()
                          as Map<String, dynamic>?;
                      final patientName = "${patient?['fName']} ${patient?['mName']} ${patient?['lName']}" ?? '';
                      // Return a GestureDetector to handle tapping on a patient
                      return GestureDetector(
                        onTap: () {
                          // Get the selected patient ID and navigate back to the previous screen
                          final selectedPatientID = filteredPatients[index].id;
                          Navigator.pop(context, selectedPatientID);
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
                  // Display an error message if there is an error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Display a loading indicator while data is being fetched
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
