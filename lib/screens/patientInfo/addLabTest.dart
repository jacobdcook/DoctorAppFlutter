import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the main widget for the Add Lab Test screen. It takes a 'patient' parameter
// which is a Map containing the first name, middle name, and last name of the patient
// for whom the lab test result is being added.
class AddLabTestScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;
  const AddLabTestScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddLabTestScreenState createState() => _AddLabTestScreenState();
}

// This is the state class for the Add Lab Test screen. It manages the state of the
// UI elements and handles the logic for adding a new lab test result to the Firestore database.
class _AddLabTestScreenState extends State<AddLabTestScreen> {
  // Create a global key for the form. This allows us to validate the form fields
  // before submitting the lab test result.
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the text fields. These controllers allow us to access
  // the values entered by the user in the text fields.
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _resultController = TextEditingController();

  // Dispose of the controllers when the widget is disposed. This ensures that
  // the resources used by the controllers are properly cleaned up.
  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  // This function is called when the user clicks the "Add Lab Test" button.
  // It first validates the form, then checks if all fields are filled, and
  // finally adds the lab test result to the Firestore database.
  Future<void> _addLabTest() async {
    // Validate the form. If the form is not valid, the function will not proceed.
    if (_formKey.currentState!.validate()) {
      try {
        // Check if all fields are filled
        if (_titleController.text == "" ||
            _dateController.text == "" ||
            _resultController.text == "") {
          // If any field is empty, show a snackbar with an error message.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in all areas'),
            ),
          );
        } else {
          // Add the lab test result to the Firestore database.
          // The document name is constructed using the patient's first, middle,
          // and last name to ensure uniqueness.
          await FirebaseFirestore.instance
              .collection('patients')
              .doc(
                  "${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}")
              .collection('labTests')
              .add({
            'title': _titleController.text,
            'date': _dateController.text,
            'details': _resultController.text,
          });

          // Show a snackbar to indicate that the lab test result was added successfully.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lab test added successfully'),
            ),
          );
        }
      } catch (e) {
        // Handle any errors that occurred during the addition of the lab test result.
        // Show a snackbar with an error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add lab test'),
          ),
        );
      }
    }
  }

  // This is the build method that creates the UI for the screen.
  // It sets up the app bar and the form with the necessary text fields and a
  // button to add the lab test result.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar title
      appBar: AppBar(
        title: Text('Add Lab Test Result'),
      ),
      // Set the body of the screen
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          // Use the global key for the form
          key: _formKey,
          child: ListView(
            children: [
              // Text field for the lab test title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              // Text field for the lab test date
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              // Text field for the lab test result
              TextFormField(
                controller: _resultController,
                decoration: InputDecoration(
                  labelText: 'Result',
                  labelStyle: TextStyle(fontSize: 14),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              // Button to add the lab test result
              ElevatedButton(
                onPressed: _addLabTest,
                child: Text('Add Lab Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
