import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDiagnosisScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const AddDiagnosisScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddDiagnosisScreenState createState() => _AddDiagnosisScreenState();
}

class _AddDiagnosisScreenState extends State<AddDiagnosisScreen> {
  final _formKey = GlobalKey<FormState>();                          
  final _titleController = TextEditingController();         
  final _dateController = TextEditingController();           
  final _detailsController = TextEditingController();           

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _addDiagnosis() async {
    if (_formKey.currentState!.validate()) {
      try {
        print("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}");
        //if (_motherController.text != "" && isMotherValid) {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").collection('medicalDiagnosis').add({
            'title': _titleController.text,
            'date': _dateController.text,
            'details': _detailsController.text,
          });
        //}
        
        // Navigate back or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Diagnosis added successfully'),
          ),
        );
      } catch (e) {
        // Handle any errors that occurred during registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add diagnosis'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diagnosis to ${widget.patient?['fName']} ${widget.patient?['lName']}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Details', labelStyle: TextStyle(fontSize: 14), alignLabelWithHint: true),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
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
