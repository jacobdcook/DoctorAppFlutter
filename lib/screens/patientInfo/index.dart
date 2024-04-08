import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GeneralPatientInformationScreen extends StatelessWidget {

  //late Map data; // to hold the info retrieved from Firestore

  // // Gets the info from firestore
  // Future<void> getPatientInformation() async {
  //   var db = FirebaseFirestore.instance;  // Database
  //   final docRef = db.collection("patients").doc("111222333");
  //   docRef.get().then(
  //     (DocumentSnapshot doc) {
  //       data = doc.data() as Map<String, String>;  
  //       // ...
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    // var db = FirebaseFirestore.instance;  // Database
    // final docRef = db.collection("patients").doc("111222333");
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     data = doc.data() as Map<String, String>;  
    //     // ...
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    CollectionReference db = FirebaseFirestore.instance.collection('patients');

    return FutureBuilder<DocumentSnapshot>(
      future: db.doc("111222333").get(), 
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("First Name: ${data['fName']}");
        }

        return Text("loading");
      },
    );
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Text(
    //         data["fName"]
    //       )
    //     ],
    //   ),
    // );
  }


}