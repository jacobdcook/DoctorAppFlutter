import 'package:doctorapp/screens/patientInfo/addRelation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientFamilyTrackerScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const PatientFamilyTrackerScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientFamilyTrackerScreen> createState() => _PatientFamilyTrackerScreenState();
}

class _PatientFamilyTrackerScreenState extends State<PatientFamilyTrackerScreen> {
  Future<DocumentSnapshot> getFatherDocument(patient) async {
    // Fetch the document of the patient's father
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('patients') .doc(patient['father']) .get();
    return document;
  }
  Future<DocumentSnapshot> getMotherDocument(patient) async {
    // Fetch the document of the patient's father
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('patients') .doc(patient['mother']) .get();
    return document;
  }
  Future<DocumentSnapshot> getSpouseDocument(patient) async {
    // Fetch the document of the patient's father
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('patients') .doc(patient['spouse']) .get();
    return document;
  }
  Future<DocumentSnapshot> getChildDocument(patient) async {
    // Fetch the document of the patient's father
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('patients') .doc(patient['child']) .get();
    return document;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Family Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddRelationScreen(patient: widget.patient)),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fatherCard(),
          motherCard(),
          spouseCard(),
          childCard(),
        ],
      ),
    );
  }

  Widget fatherCard() {
    if (widget.patient?['father'] == "") {
      return SizedBox.shrink();  // Show nothing 
    } else {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.patient!['father'] ?? ''}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Relation: father',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot>(
                future: getFatherDocument(widget.patient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a progress indicator while fetching data
                  }
                  if (snapshot.hasError) {
                    return Text('ERROR [69]: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return SizedBox.shrink(); // Handle case when document doesn't exist
                  }
                  
                  // Extract the desired field from the document snapshot
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  String fieldValue = data['medicalHistory']; 
                  
                  // Display the field value within a card in a column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Medical History: ${fieldValue}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget motherCard() {
    if (widget.patient?['mother'] == "") {
      return SizedBox.shrink();  // Show nothing 
    } else {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.patient!['mother'] ?? ''}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Relation: mother',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot>(
                future: getMotherDocument(widget.patient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a progress indicator while fetching data
                  }
                  if (snapshot.hasError) {
                    return Text('ERROR [69]: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return SizedBox.shrink(); // Handle case when document doesn't exist
                  }
                  
                  // Extract the desired field from the document snapshot
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  String fieldValue = data['medicalHistory']; 
                  
                  // Display the field value within a card in a column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Medical History: ${fieldValue}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget spouseCard() {
    if (widget.patient?['spouse'] == "") {
      return SizedBox.shrink();  // Show nothing 
    } else {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.patient!['spouse'] ?? ''}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Relation: spouse',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot>(
                future: getSpouseDocument(widget.patient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a progress indicator while fetching data
                  }
                  if (snapshot.hasError) {
                    return Text('ERROR [69]: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return SizedBox.shrink(); // Handle case when document doesn't exist
                  }
                  
                  // Extract the desired field from the document snapshot
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  String fieldValue = data['medicalHistory']; 
                  
                  // Display the field value within a card in a column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Medical History: ${fieldValue}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget childCard() {
    if (widget.patient?['child'] == "") {
      return SizedBox.shrink();  // Show nothing 
    } else {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.patient!['child'] ?? ''}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Relation: child',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot>(
                future: getChildDocument(widget.patient),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a progress indicator while fetching data
                  }
                  if (snapshot.hasError) {
                    return Text('ERROR [69]: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return SizedBox.shrink(); // Handle case when document doesn't exist
                  }
                  
                  // Extract the desired field from the document snapshot
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  String fieldValue = data['medicalHistory']; 
                  
                  // Display the field value within a card in a column
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Medical History: ${fieldValue}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }  
}
