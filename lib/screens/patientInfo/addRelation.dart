import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRelationScreen extends StatefulWidget {
  final Map<String, dynamic>? patient;

  const AddRelationScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddRelationScreenState createState() => _AddRelationScreenState();
}

class _AddRelationScreenState extends State<AddRelationScreen> {
  final _formKey = GlobalKey<FormState>();                          
  final _motherController = TextEditingController();         
  final _fatherController = TextEditingController();           
  final _spouseController = TextEditingController();           
  final _childController = TextEditingController();            
  bool isValid = true;  // Is the entered person a patient in the database

  @override
  void dispose() {
    _motherController.dispose();
    _fatherController.dispose();
    _spouseController.dispose();
    _childController.dispose();
    super.dispose();
  }

  Future<void> _addRelation() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get all patient docs
        FirebaseFirestore.instance.collection("patients").get().then(
          (querySnapshot) {
            print("Successfully completedYAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            for (var docSnapshot in querySnapshot.docs) {
              if (_motherController.text != docSnapshot.id || _motherController.text == "") {
                isValid = false;
              }
              if (_fatherController.text != docSnapshot.id || _motherController.text == "") {
                isValid = false;
              }
              if (_spouseController.text != docSnapshot.id || _motherController.text == "") {
                isValid = false;
              }
              if (_childController.text != docSnapshot.id || _motherController.text == "") {
                isValid = false;
              }
            }

          },
          onError: (e) => print("Error completing: $e"),
        );
        
        await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").update({
          'mother': _motherController.text,
          'father': _fatherController.text,
          'spouse': _spouseController.text,
          'child': _childController.text,
        });

        // Navigate back or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Relation added successfully'),
          ),
        );
      } catch (e) {
        // Handle any errors that occurred during registration
        print('Error adding relation: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add relation'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Relation to ${widget.patient?['fName']} ${widget.patient?['lName']}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _motherController,
                decoration: InputDecoration(labelText: 'Mother', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _fatherController,
                decoration: InputDecoration(labelText: 'father', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _spouseController,
                decoration: InputDecoration(labelText: 'Spouse', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextFormField(
                controller: _childController,
                decoration: InputDecoration(labelText: 'Child', labelStyle: TextStyle(fontSize: 14)),
              ),
              
              SizedBox(height: 16.0),
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
