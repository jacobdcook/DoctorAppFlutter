import 'package:doctorapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  Future<String> getPatientName(DocumentReference patientRef) async {
    DocumentSnapshot patientSnapshot = await patientRef.get();
    if (patientSnapshot.exists) {
      Map<String, dynamic> patientData =
          patientSnapshot.data() as Map<String, dynamic>;
      return patientData['name'] ?? 'No name provided';
    } else {
      return 'Unknown';
    }
  }

  Future<void> deleteAppointment(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(docId)
          .delete();
      print('Appointment deleted successfully');
    } catch (e) {
      print('Failed to delete appointment: $e');
    }
  }

  void updateAppointment(String docId, String serviceName, String dateString,
      String timeString, String patientName) async {
    try {
      DateTime localDate = DateFormat('MMM dd, yyyy').parse(dateString, true);
      TimeOfDay time = parseTimeOfDay(timeString);
      DateTime localDateTime = DateTime(localDate.year, localDate.month,
          localDate.day, time.hour, time.minute);

      var location = tz.getLocation('America/Los_Angeles');
      tz.TZDateTime scheduledDate = tz.TZDateTime.from(localDateTime, location);

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(docId)
          .update({
        'service': serviceName,
        'schedule': Timestamp.fromDate(scheduledDate),
        'patient_name':
            patientName // Ensure this matches the field name in Firestore
      });

      print('Appointment updated successfully'); // Debug print
    } catch (e) {
      print('Failed to update appointment: $e'); // Print any errors
    }
  }

  TimeOfDay parseTimeOfDay(String formattedString) {
    int hour, minute;
    List<String> parts = formattedString.split(' ');
    List<String> timeParts = parts[0].split(':');
    hour = int.parse(timeParts[0]);
    minute = int.parse(timeParts[1]);

    if (parts[1].toUpperCase() == 'PM' && hour != 12) {
      hour = (hour + 12) % 24;
    } else if (parts[1].toUpperCase() == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  void showEditDialog(BuildContext context, Map<String, dynamic> data,
      String documentId) async {
    final TextEditingController serviceController =
        TextEditingController(text: data['service']);
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Appointment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: serviceController,
                  decoration:
                      const InputDecoration(hintText: "Enter service name"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(hintText: "Select date"),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null) {
                      DateTime localDate = DateTime(
                          pickedDate.year, pickedDate.month, pickedDate.day);
                      dateController.text =
                          DateFormat('MMM dd, yyyy').format(localDate);
                    }
                  },
                ),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(hintText: "Select time"),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      timeController.text = pickedTime.format(context);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                updateAppointment(
                    documentId,
                    serviceController.text,
                    dateController.text,
                    timeController.text,
                    ''); // This call now passes an empty string for patient's name
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking List'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('appointments')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  DateTime utcScheduleDate =
                      (data['schedule'] as Timestamp).toDate();

                  // Convert UTC DateTime to a timezone-specific DateTime
                  var location = tz.getLocation('America/Los_Angeles');
                  tz.TZDateTime pacificScheduleDate =
                      tz.TZDateTime.from(utcScheduleDate, location);

                  // Format the timezone-specific DateTime
                  String formattedDate =
                      DateFormat('MMM dd, yyyy').format(pacificScheduleDate);
                  String formattedTime =
                      DateFormat.jm().format(pacificScheduleDate);

                  DocumentReference patientRef = data['patient'];

                  return FutureBuilder(
                    future: getPatientName(patientRef),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> patientNameSnapshot) {
                      if (patientNameSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        width: Get.width,
                        height: Get.height * 0.23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 6),
                              color: Colors.black26.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service Name: ${data['service']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Booking Date: $formattedDate'),
                            const SizedBox(height: 8.0),
                            Text(
                              'Allocated Time Slot: $formattedTime',
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Patient Name: ${patientNameSnapshot.data ?? 'Unknown'}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => showEditDialog(
                                      context, data, document.id),
                                  child: Container(
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorssA.primaryColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => deleteAppointment(document.id),
                                  child: Container(
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorssA.errorColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
