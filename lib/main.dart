import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/screens/splash/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Firebase options, auto-generated by the FlutterFire CLI
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication

const firebaseConfig = {
  'apiKey': 'AIzaSyBHUKcdunuIEoJzfoezc5QZ6rm9k3bjngI',
  'authDomain': 'doctorappflutter.firebaseapp.com',
  'projectId': 'doctorappflutter',
  'storageBucket': 'doctorappflutter.appspot.com',
  'messagingSenderId': '367335719241',
  'appId': '1:367335719241:web:76bd84f2e0d8f20faada98',
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getSplash(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}

// Firebase Authentication
Future<UserCredential> signInWithEmailAndPassword(
  String email,
  String password,
) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userCredential = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return userCredential;
}

Future<UserCredential> createUserWithEmailAndPassword(
  String email,
  String password,
) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return userCredential;
}

Future<void> signOut() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();
}

User? getCurrentUser() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return auth.currentUser;
}