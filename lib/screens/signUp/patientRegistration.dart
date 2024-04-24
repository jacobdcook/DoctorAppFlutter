import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientRegistrationScreen extends StatefulWidget {
  @override
  _PatientRegistrationScreenState createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();                          
  final _fNameController = TextEditingController();           // First name
  final _mNameController = TextEditingController();           // Middle name
  final _lNameController = TextEditingController();           // Last name
  final _dOBController = TextEditingController();             // Date of irth
  final _bloodGroupController =  TextEditingController();     // Blood group
  final _rHFactorController = TextEditingController();        // RH facter
  final _maritalStatusController = TextEditingController();   // Marital Status
  final _ageController = TextEditingController();             // Age (Years/Month/Day)
  final _phoneResidenceController = TextEditingController();  // ???
  final _phoneController = TextEditingController();           // Phone number
  final _emailController = TextEditingController();           // Email
  final _eCNameController = TextEditingController();          // Emergency contact name
  final _eCPhoneController = TextEditingController();         // Emergency contact phone number

  @override
  void dispose() {
    _fNameController.dispose();
    _mNameController.dispose();
    _lNameController.dispose();
    _dOBController.dispose();
    _bloodGroupController.dispose();
    _rHFactorController.dispose();
    _maritalStatusController.dispose();
    _ageController.dispose();
    _phoneResidenceController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _eCNameController.dispose();
    _eCPhoneController.dispose();
    super.dispose();
  }

  Future<void> _registerPatient() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Store the patient data in Firestore
        // Reference to the patients collection on Firestore
        CollectionReference patientsCollection = FirebaseFirestore.instance.collection("patients");  

        // Create new document
        DocumentReference patientDocumentReference = patientsCollection.doc("${_fNameController.text}${_mNameController.text}${_lNameController.text}");
        // Add all the patient information to Firestore
        await patientDocumentReference.set({
          'fName': _fNameController.text,
          'mName': _mNameController.text,
          'lName': _lNameController.text,
          'dOB': _dOBController.text,
          'bloodGroup': _bloodGroupController.text,
          'rHFactor': _rHFactorController.text,
          'maritalStatus': _maritalStatusController.text,
          'age': _ageController.text,
          'phoneResidence': _phoneResidenceController.text,
          'phone': _phoneController.text,
          'email': _emailController.text,
          'eCName': _eCNameController.text,
          'eCPhone': _eCPhoneController.text,
          'mother': "",
          'father': "",
          'spouse': "",
          'child': "",
          'medicalHistory': "",
        });
        
        // Navigate back or show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Patient registered successfully'),
          ),
        );
      } catch (e) {
        // Handle any errors that occurred during registration
        print('Error registering patient: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register patient'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register a Patient'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fNameController,
                decoration: InputDecoration(labelText: 'First Name', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s first';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mNameController,
                decoration: InputDecoration(labelText: 'Middle Name', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s middle name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lNameController,
                decoration: InputDecoration(labelText: 'Last Name', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dOBController,
                decoration: InputDecoration(labelText: 'Date of Birth', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s date of birth';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bloodGroupController,
                decoration: InputDecoration(labelText: 'Blood Group', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s blood group';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rHFactorController,
                decoration: InputDecoration(labelText: 'RH Factor', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s RH Factor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _maritalStatusController,
                decoration: InputDecoration(labelText: 'Marital Status', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s marital status';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneResidenceController,
                decoration: InputDecoration(labelText: 'Phone Residence', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s phone residence';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eCNameController,
                decoration: InputDecoration(labelText: 'Emergency Contact Name', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s emergency contact name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eCPhoneController,
                decoration: InputDecoration(labelText: 'Emergency Contact Phone Number', labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the patient\'s emergency contact phone number';
                  }
                  return null;
                },
              ),
              // // The 4 following fields are for Family Tracking. They can be blank because they can be added
              // TextFormField(
              //   controller: _motherController,
              //   decoration: InputDecoration(labelText: 'Mother', labelStyle: TextStyle(fontSize: 14)),
              //   // validator: (value) {
              //   //   if (value == null || value.isEmpty) {
              //   //     return 'Please enter the patient\'s mother\'s full name';
              //   //   }
              //   //   return null;
              //   // },
              // ),
              // TextFormField(
              //   controller: _fatherController,
              //   decoration: InputDecoration(labelText: 'Father', labelStyle: TextStyle(fontSize: 14)),
              //   // validator: (value) {
              //   //   if (value == null || value.isEmpty) {
              //   //     return 'Please enter the patient\'s father\'s full name';
              //   //   }
              //   //   return null;
              //   // },
              // ),
              // TextFormField(
              //   controller: _spouseController,
              //   decoration: InputDecoration(labelText: 'spouse', labelStyle: TextStyle(fontSize: 14)),
              //   // validator: (value) {
              //   //   if (value == null || value.isEmpty) {
              //   //     return 'Please enter the patient\'s spouse\'s full name';
              //   //   }
              //   //   return null;
              //   // },
              // ),
              // TextFormField(
              //   controller: _motherController,
              //   decoration: InputDecoration(labelText: 'child', labelStyle: TextStyle(fontSize: 14)),
              //   // validator: (value) {
              //   //   if (value == null || value.isEmpty) {
              //   //     return 'Please enter the patient\'s child\'s full name';
              //   //   }
              //   //   return null;
              //   // },
              // ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _registerPatient,
                child: Text('Register Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
