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

  // Is the entered person a patient in the database        
  bool isMotherValid = false;  
  bool isFatherValid = false;  
  bool isSpouseValid = false;  
  bool isChildValid = false;  

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
        // Get all patient docs, this is to ensure the relation being made is between two patients in the database
        FirebaseFirestore.instance.collection("patients").get().then(
          (querySnapshot) {
            for (var docSnapshot in querySnapshot.docs) {
              if (_motherController.text == docSnapshot.id || _motherController.text == "") {
                isMotherValid = true;
              }
              if (_fatherController.text == docSnapshot.id || _fatherController.text == "") {
                isFatherValid = true;
              }
              if (_spouseController.text == docSnapshot.id || _spouseController.text == "") {
                isSpouseValid = true;
              }
              if (_childController.text == docSnapshot.id || _childController.text == "") {
                isChildValid = true;
              }
            }

          },
          onError: (e) => print("Error completing: $e"),
        );
        
        if (_motherController.text != "" && isMotherValid) {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").update({
            'mother': _motherController.text,
          });
        }
        if (_fatherController.text != "" && isFatherValid) {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").update({
            'father': _fatherController.text,
          });
        }
        if (_spouseController.text != "" && isSpouseValid) {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").update({
            'spouse': _spouseController.text,
          });
        }
        if (_childController.text != "" && isChildValid) {
          await FirebaseFirestore.instance.collection('patients').doc("${widget.patient?['fName']}${widget.patient?['mName']}${widget.patient?['lName']}").update({
            'child': _childController.text,
          });
        }

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
                decoration: InputDecoration(labelText: 'Father', labelStyle: TextStyle(fontSize: 14)),
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
