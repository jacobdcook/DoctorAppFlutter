import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const AddPrescriptionScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dosageController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void dispose() {
    // Dispose the text editing controllers when the widget is disposed
    _titleController.dispose();
    _dosageController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _addPrescription() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Check if all fields are filled before adding a prescription
        if (_titleController.text == "" ||
            _dosageController.text == "" ||
            _startDateController.text == "" ||
            _endDateController == "") {
          // Show a snackbar message if any field is empty
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in all areas'),
            ),
          );
        } else {
          // Add the prescription to Firestore
          await FirebaseFirestore.instance
              .collection('patients')
              .doc(
                  "${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}")
              .collection('prescriptions')
              .add({
            'title': _titleController.text,
            'dosage': _dosageController.text,
            'startDate': _startDateController.text,
            'endDate': _endDateController.text,
          });

          // Show a success message using a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Prescription added successfully'),
            ),
          );
        }
      } catch (e) {
        // Handle any errors that occurred during the process
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add prescription'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Prescription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Text field for prescription title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                    labelText: 'Title', labelStyle: TextStyle(fontSize: 14)),
              ),
              // Text field for prescription dosage
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(
                    labelText: 'Dosage', labelStyle: TextStyle(fontSize: 14)),
              ),
              // Text field for prescription start date
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                    labelText: 'Start Date',
                    labelStyle: TextStyle(fontSize: 14)),
              ),
              // Text field for prescription end date
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                    labelText: 'End Date', labelStyle: TextStyle(fontSize: 14)),
              ),
              SizedBox(height: 16.0),
              // Button to add the prescription
              ElevatedButton(
                onPressed: _addPrescription,
                child: Text('Add Prescription'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
