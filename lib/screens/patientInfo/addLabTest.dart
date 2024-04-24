import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddLabTestScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const AddLabTestScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddLabTestScreenState createState() => _AddLabTestScreenState();
}

class _AddLabTestScreenState extends State<AddLabTestScreen> {
  final _formKey = GlobalKey<FormState>();                          
  final _titleController = TextEditingController();         
  final _dateController = TextEditingController();           
  final _resultController = TextEditingController();           

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  Future<void> _addLabTest() async {
    if (_formKey.currentState!.validate()) {
      try {
        // All boxes need to be filled to successfully add a lab test result
        if (_titleController.text == "" || _dateController.text == "" || _resultController.text == "") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in all areas'),
            ),
          );
        } else {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").collection('labTests').add({
            'title': _titleController.text,
            'date': _dateController.text,
            'details': _resultController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lab test added successfully'),
            ),
          );
        }
          
      } catch (e) {
        // Handle any errors that occurred during registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add lab test'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lab Test Result'),
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
                controller: _resultController,
                decoration: InputDecoration(labelText: 'Result', labelStyle: TextStyle(fontSize: 14), alignLabelWithHint: true),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addLabTest,
                child: Text('Add LabTest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
