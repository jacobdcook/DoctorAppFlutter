import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRelationScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const AddRelationScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddRelationScreenState createState() => _AddRelationScreenState();
}

class _AddRelationScreenState extends State<AddRelationScreen> {
  // Create a key to uniquely identify the form
  final _formKey = GlobalKey<FormState>();

  // Initialize text editing controllers for each relation field
  final _motherController = TextEditingController();
  final _fatherController = TextEditingController();
  final _spouseController = TextEditingController();
  final _childController = TextEditingController();

  // Flags to track the validity of each relation field
  bool isMotherValid = false;
  bool isFatherValid = false;
  bool isSpouseValid = false;
  bool isChildValid = false;

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is disposed
    _motherController.dispose();
    _fatherController.dispose();
    _spouseController.dispose();
    _childController.dispose();
    super.dispose();
  }

  Future<void> _addRelation() async {
    // Validate the form before attempting to add the relations
    if (_formKey.currentState!.validate()) {
      try {
        // Fetch all patient documents to ensure the relations are valid
        await _validateRelations();

        // Update the patient document with the new relations
        await _updatePatientRelations();

        // Show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Relation added successfully'),
          ),
        );
      } catch (e) {
        // Handle any errors that occurred during the process
        print('Error adding relation: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add relation'),
          ),
        );
      }
    }
  }

  Future<void> _validateRelations() async {
    // Fetch all patient documents from the database
    final querySnapshot =
        await FirebaseFirestore.instance.collection("patients").get();

    // Iterate through the documents and check if the entered relations are valid
    for (var docSnapshot in querySnapshot.docs) {
      if (_motherController.text == docSnapshot.id ||
          _motherController.text == "") {
        isMotherValid = true;
      }
      if (_fatherController.text == docSnapshot.id ||
          _fatherController.text == "") {
        isFatherValid = true;
      }
      if (_spouseController.text == docSnapshot.id ||
          _spouseController.text == "") {
        isSpouseValid = true;
      }
      if (_childController.text == docSnapshot.id ||
          _childController.text == "") {
        isChildValid = true;
      }
    }
  }

  Future<void> _updatePatientRelations() async {
    // Get the patient document reference
    final patientRef = FirebaseFirestore.instance.collection('patients').doc(
        "${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}");

    // Update the patient document with the new relations
    if (_motherController.text != "" && isMotherValid) {
      await patientRef.update({
        'mother': _motherController.text,
      });
    }
    if (_fatherController.text != "" && isFatherValid) {
      await patientRef.update({
        'father': _fatherController.text,
      });
    }
    if (_spouseController.text != "" && isSpouseValid) {
      await patientRef.update({
        'spouse': _spouseController.text,
      });
    }
    if (_childController.text != "" && isChildValid) {
      await patientRef.update({
        'child': _childController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Add Relation to ${widget.patient?['fName']} ${widget.patient?['lName']}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Text form fields for each relation
              TextFormField(
                controller: _motherController,
                decoration: InputDecoration(
                    labelText: 'Mother', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _fatherController,
                decoration: InputDecoration(
                    labelText: 'Father', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _spouseController,
                decoration: InputDecoration(
                    labelText: 'Spouse', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _childController,
                decoration: InputDecoration(
                    labelText: 'Child', labelStyle: TextStyle(fontSize: 14)),
              ),

              // Add some spacing between the form fields and the button
              SizedBox(height: 16.0),

              // Add relation button
              ElevatedButton(
                onPressed: _addRelation,
                child: Text('Add Relations'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
