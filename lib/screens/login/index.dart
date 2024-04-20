import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/screens/home/index.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/customButton.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = userCredential.user;
      if (user != null) {
        print('User logged in: ${user.email}');

        // Find the patient document with the user's UID
        DocumentSnapshot patientSnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .get();

        if (patientSnapshot.exists) {
          String firstName = patientSnapshot.get('name');

          // Store the user's first name in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .set({
            'name': firstName,
            'email': user.email,
          });
        }

        Get.off(Home());
      } else {
        print('User is null');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: ColorssA.whiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/images/auth.jpg",
                    height: 250,
                    width: 350,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Sign in',
                  style: poppinsMedium.copyWith(
                    color: ColorssA.blackColor,
                    fontSize: Dimensions.fontSizeOverLarge,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: _emailController,
                  lableText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  onChanged: (email) {
                    print('onChange-------------- ');
                  },
                  isEmail: true,
                  hintText: 'Enter Your Email',
                  titleText: 'Email',
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  lableText: "Password",
                  onChanged: (password) {},
                  hintText: 'Enter Your Password',
                  titleText: 'Password',
                  maxLines: 1,
                  isPassword: true,
                  selectedPass: true,
                ),
                SizedBox(height: 15),
                Center(
                  child: ButtonWight(
                    buttonText: _isLoading ? "Loading..." : "Login",
                    borderButton: false,
                    width: Get.width * 0.9,
                    height: Get.height * 0.08,
                    loading: _isLoading,
                    onClick: _isLoading ? null : _signInWithEmailAndPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
