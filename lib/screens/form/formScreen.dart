import 'package:doctorapp/screens/form/patientSelection.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/customButton.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class Appointment {
  String name = "";
  String service = "";
  late DateTime schedule;
  late DocumentReference patientRef;
  late DocumentReference userRef;

  @override
  String toString() {
    return "Name: $name, Schedule: $schedule, Service: $service";
  }

  Map<String, dynamic> toJson() => {
        'patient': patientRef,
        'schedule': schedule,
        'service': service,
        'user': userRef
      };
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class _FormPageState extends State<FormPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController patientInput = TextEditingController();
  Appointment appointment = Appointment();
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    patientInput.text = "";
    super.initState();
  }

  String? _selectedItem;
  List<String> items = [
    "Consultation",
    "Dental",
    "Heart",
    "Hospitals",
    "Medicals",
    "Physics",
    "Skin",
    "Surgeon",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Patient Name',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.2))),
                height: MediaQuery.of(context).size.width * 0.14,
                child: Center(
                    child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.person,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  controller: patientInput,
                  readOnly: true,
                  onTap: () async {
                    _navigateAndGetSelection(context);
                  },
                ))),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Select Date',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.2))),
                height: MediaQuery.of(context).size.width * 0.14,
                child: Center(
                    child: TextField(
                  controller: dateInput,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    // pick day
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate == null) {
                      return;
                    }

                    // pick time
                    final TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (pickedTime == null) {
                      return;
                    }

                    // combine date and time
                    DateTime finalDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute);

                    String formattedDate = DateFormat('MMM dd, yyyy | hh:mm a')
                        .format(finalDateTime);
                    appointment.schedule = finalDateTime;
                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  },
                ))),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Select Services',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Container(
              height: Get.height * 0.07,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: false,
                  isExpanded: true,
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue;
                      appointment.service = newValue!;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      enabled: true,
                      value: value,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                          // width: Get.width,
                          child: Text(value)),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ButtonWight(
          buttonText: "Add Appointment",
          borderButton: false,
          width: Get.width * 0.9,
          height: Get.height * 0.08,
          // loading: load,
          onClick: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Added Succefully',
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            Get.back();

            // add currently logged in user to appointments doc
            final FirebaseAuth auth = FirebaseAuth.instance;
            final User user = auth.currentUser!;
            DocumentReference userRef = db.collection("users").doc(user.uid);
            appointment.userRef = userRef;

            // add a new document with a generated ID
            db.collection("appointments").add(appointment.toJson()).then(
                (DocumentReference doc) =>
                    print('DocumentSnapshot added with ID: ${doc.id}'));
          },
        ),
      ),
    );
  }

  Future<void> _navigateAndGetSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Patient Selection screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PatientSelectionScreen()),
    );

    if (!context.mounted) return;

    // get doc of selected patient
    DocumentReference patientRef = db.collection("patients").doc(result);
    // get first and last name of selected patient
    patientRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        // update label to selected patient's first and last name
        patientInput.text = data['name'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    appointment.patientRef = patientRef;
  }
}

Widget profileTabs(
    BuildContext context, String img, title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(
          left: 20, right: 20, bottom: Dimensions.PADDING_SIZE_DEFAULT),
      width: Get.width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(5, 8),
                color: Colors.black26.withOpacity(0.1))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Image.asset(
          //     img,width: 20,height: 20,
          //   ),
          // ),
          Text(
            title,
            style: poppinsMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).hintColor),
          ),
          Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.arrow_forward_ios_outlined))
        ],
      ),
    ),
  );
}
