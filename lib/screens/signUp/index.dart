import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/customButton.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _globalKey,
      backgroundColor: ColorssA.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(top: Get.height * 0.1),
              height: Get.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Sign up',
                              style: poppinsMedium.copyWith(
                                  color: ColorssA.blackColor,
                                  fontSize: Dimensions.fontSizeOverLarge,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // Text(
                            //   'E-mail',
                            //   style: TextStyle(
                            //       color: ColorssA.blackColor,
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.w500),
                            // ),
                            MyTextField(
                                controller: _emailController,
                                lableText: 'Email',isEmail: true,
                                textInputType: TextInputType.emailAddress,
                                // onTap: () {},
                                // onSubmit: () {},
                                onChanged: (email) {
                                  print('onChange-------------- ');

                                },
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
                              // onTap: () {},
                              // onSubmit: () {},
                              onChanged: (password) {

                              },
                              hintText: 'Enter Your Password',
                              titleText: 'Password',
                              lableText: 'Password',
                              maxLines: 1,
                              isPassword: true,
                              selectedPass: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ButtonWight(
                                buttonText: "Sign Up",
                                borderButton: false,
                                width: Get.width * 0.9,
                                height: Get.height * 0.08,

                                onClick: () => {


                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.getLogin());
                              },
                              child: Center(
                                child: Container(
                                  margin:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                      children: [
                                        const TextSpan(
                                          text: "Already have account? ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Login',
                                          style: TextStyle(
                                              color: ColorssA.blackColor,
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
                            const SizedBox(
                              height: 15,
                            ),
                            // const Center(
                            //   child: Center(
                            //     child: Text(
                            //       '--- Or Sign up with ---',
                            //       style: TextStyle(
                            //         // color: ColorssA.Black.withOpacity(0.5),
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 15),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 15,
                            ),
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
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.center,
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
                            const SizedBox(
                              height: 20,
                            ),
                            // Center(
                            //   child: Text(
                            //     'By signing up you agree with our T&C and privacy policy',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //         color: ColorssA.blackColor, fontSize: 12),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
