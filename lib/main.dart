import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/screens/splash/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor APP',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior(),
      initialRoute: RouteHelper.getSplash(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),

      // home: BottomTapBarScreen(),
    );
  }
}


