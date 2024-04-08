import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/screens/home/index.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/customButton.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
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

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      backgroundColor: ColorssA.whiteColor,
      body:  SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(child: Image.asset("assets/images/auth.jpg",height: 250,width: 350,)),


                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Sign in',
                  style: poppinsMedium.copyWith(
                      color: ColorssA.blackColor,
                      fontSize: Dimensions.fontSizeOverLarge,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),


                MyTextField(
                    controller: _emailController,
                    lableText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    // onTap: () {},
                    // onSubmit: () {},
                    onChanged: (email) {
                      print('onChange-------------- ');
                      // loginController.addSigupdata(
                      //     "email", email);
                    } ,isEmail: true,
                    hintText: 'Enter Your Email',
                    titleText: 'Email'),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Password',
                //   style: TextStyle(
                //       color: ColorssA.blackColor,
                //       fontSize: 15,
                //       fontWeight: FontWeight.w500),
                // ),
                MyTextField(
                  controller: _passwordController,
                  lableText: "Password",

                  // onTap: () {},
                  // onSubmit: () {},
                  onChanged: (password) {
                    // loginController.addSigupdata(
                    //     "password", password);
                  },
                  hintText: 'Enter Your Password',
                  titleText: 'Password',
                  maxLines: 1,
                  isPassword: true,
                  selectedPass: true,
                ),


                SizedBox(
                  height:15,
                ),
                Center(
                  child: ButtonWight(
                    buttonText: "Login",
                    borderButton: false,
                    width: Get.width * 0.9,
                    height: Get.height * 0.08,
                    // loading: load,
                    onClick: () =>
                    {
                      Get.to(Home())

                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getSignUp());
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).hintColor),
                          children: [
                            const TextSpan(
                              text: "Don’t have account ? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                  color:  ColorssA.blackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                  TextDecoration.none),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Center(
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(width: 100,height: 1,color: Colors.black.withOpacity(.2),),
                //       Text(
                //         ' Or login with ',
                //         style: TextStyle(
                //           // color: ColorssA.Black.withOpacity(0.5),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 15),
                //       ),
                //       Container(width: 100,height: 1,color: Colors.black.withOpacity(.2),),
                //
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Center(
                //   child: Container(
                //     margin:
                //     const EdgeInsets.symmetric(horizontal: 5),
                //     decoration: BoxDecoration(
                //         gradient: ColorssA.AppLinears,
                //         borderRadius: BorderRadius.circular(10)),
                //     padding:
                //     const EdgeInsets.only(left: 0, right: 0),
                //     child: MaterialButton(
                //       padding:
                //       const EdgeInsets.symmetric(vertical: 8),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       color: Colors.transparent,
                //       // color: Colors.teal[100],
                //       elevation: 0,
                //       onPressed: () {
                //         // loginController.loginWithSignup(context);
                //       },
                //
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset(
                //             Images.google,
                //             width: 30,
                //             height: 30,
                //           ),
                //           const SizedBox(
                //             width: 20,
                //           ),
                //           Text(
                //             "Continue with Google",
                //             style: TextStyle(
                //                 color: ColorssA.whiteColor,
                //                 fontSize: 15),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
