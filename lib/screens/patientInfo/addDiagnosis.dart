import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the main widget for the Add Diagnosis screen. It takes a 'patient' parameter
// which is a Map containing the first name, middle name, and last name of the patient
// for whom the diagnosis is being added.
class AddDiagnosisScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;
  const AddDiagnosisScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddDiagnosisScreenState createState() => _AddDiagnosisScreenState();
}

// This is the state class for the Add Diagnosis screen. It manages the state of the
// UI elements and handles the logic for adding a new diagnosis to the Firestore database.
class _AddDiagnosisScreenState extends State<AddDiagnosisScreen> {
  // Create a global key for the form. This allows us to validate the form fields
  // before submitting the diagnosis.
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the text fields. These controllers allow us to access
  // the values entered by the user in the text fields.
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _detailsController = TextEditingController();

  // Dispose of the controllers when the widget is disposed. This ensures that
  // the resources used by the controllers are properly cleaned up.
  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // This function is called when the user clicks the "Add Diagnosis" button.
  // It first validates the form, then checks if all fields are filled, and
  // finally adds the diagnosis to the Firestore database.
  Future<void> _addDiagnosis() async {
    // Validate the form. If the form is not valid, the function will not proceed.
    if (_formKey.currentState!.validate()) {
      try {
        // Check if all fields are filled
        if (_titleController.text == "" ||
            _dateController.text == "" ||
            _detailsController.text == "") {
          // If any field is empty, show a snackbar with an error message.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in all areas'),
            ),
          );
        } else {
          // Add the diagnosis to the Firestore database.
          // The document name is constructed using the patient's first, middle,
          // and last name to ensure uniqueness.
          await FirebaseFirestore.instance
              .collection('patients')
              .doc(
                  "${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}")
              .collection('medicalDiagnosis')
              .add({
            'title': _titleController.text,
            'date': _dateController.text,
            'details': _detailsController.text,
          });

          // Show a snackbar to indicate that the diagnosis was added successfully.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Diagnosis added successfully'),
            ),
          );
        }
      } catch (e) {
        // Handle any errors that occurred during the addition of the diagnosis.
        // Show a snackbar with an error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add diagnosis'),
          ),
        );
      }
    }
  }

  // This is the build method that creates the UI for the screen.
  // It sets up the app bar and the form with the necessary text fields and a
  // button to add the diagnosis.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar title
      appBar: AppBar(
        title: Text(
            'Add Diagnosis to ${widget.patient?['fName']} ${widget.patient?['lName']}'),
      ),
      // Set the body of the screen
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          // Use the global key for the form
          key: _formKey,
          child: ListView(
            children: [
              // Text field for the diagnosis title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              // Text field for the diagnosis date
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              // Text field for the diagnosis details
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(
                  labelText: 'Details',
                  labelStyle: TextStyle(fontSize: 14),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              // Button to add the diagnosis
              ElevatedButton(
                onPressed: _addDiagnosis,
                child: Text('Add Diagnosis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
