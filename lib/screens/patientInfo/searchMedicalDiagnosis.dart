import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/screens/patientInfo/medicalDiagnosis.dart';
import 'package:flutter/material.dart';

class SearchMedicalDiagnosisScreen extends StatefulWidget {
  const SearchMedicalDiagnosisScreen({Key? key}) : super(key: key);

  @override
  _SearchMedicalDiagnosisScreenState createState() =>_SearchMedicalDiagnosisScreenState();
}

class _SearchMedicalDiagnosisScreenState extends State<SearchMedicalDiagnosisScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Diagnosis'),
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
                      final patientName = patient?['fName'] ?? '';
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                MedicalDiagnosisScreen(patient: patient),
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