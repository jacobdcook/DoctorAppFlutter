import 'package:doctorapp/appoinmentBook/index.dart';
import 'package:doctorapp/helper/routeHelper.dart';
import 'package:doctorapp/screens/bookingList/index.dart';
import 'package:doctorapp/screens/form/formScreen.dart';
import 'package:doctorapp/screens/profile/index.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorapp/screens/patientInfo/index.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List category = [
    {"name": "Consultation", "color": Colors.red.withOpacity(0.5)},
    {"name": "Dental", "color": Colors.blue.withOpacity(0.5)},
    {"name": "Heart", "color": Colors.green.withOpacity(0.5)},
    {"name": "Hospitals", "color": Colors.purple.withOpacity(0.5)},
    {"name": "Medicals", "color": Colors.amber.withOpacity(0.5)},
    {"name": "Physics", "color": Colors.teal.withOpacity(0.5)},
    {"name": "Skin", "color": Colors.lightGreenAccent.withOpacity(0.5)},
    {"name": "Surgeon", "color": Colors.blue.withOpacity(0.5)},
  ];

  List doctorList = [
    {"name": "John", "specialist": "Heart", "img": "assets/images/doc3.jpg"},
    {
      "name": "Kajol",
      "specialist": "Gay conic",
      "img": "assets/images/doc2.png"
    },
    {"name": "Gunjan", "specialist": "Dental", "img": "assets/images/doc.jpg"}
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorssA.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.person_pin,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'John Dave',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Book Appointment'),
              onTap: () {
                Get.to(FormPage());
              },
            ),
            ListTile(
              title: const Text('Booking List'),
              onTap: () {
                Get.to(BookingList());
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Get.to(Profile());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Text(
                    'Logout ',
                    style: TextStyle(color: Colors.red),
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  )
                ],
              ),
              onTap: () {
                Get.toNamed(RouteHelper.getLogin());
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Icon(Icons.menu)),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(Icons.person_pin),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Find',
                      style: TextStyle(
                          color: ColorssA.blackColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' Your Doctor',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "search...",
                      border: InputBorder.none),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 2 / 2),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(FormPage());
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: category[index]['color']),
                          child: Icon(Icons.medical_services),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            category[index]['name'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: const [
                    Text(
                      'Top Doctors',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: Get.height * 0.35,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: index == 0 ? 15 : 0,
                          right: 15,
                          top: 5,
                          bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 6),
                              color: Colors.black26.withOpacity(0.15))
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 180,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.1)),
                            child: Image.asset(
                              doctorList[index]['img'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Center(
                              child: Text(
                            'Dr. ${doctorList[index]['name']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          )),
                          Center(
                              child: Text(
                            doctorList[index]['specialist'],
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(GeneralPatientInformationScreen());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: Get.width,
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                      color: ColorssA.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Patient Info',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
              // InkWell(
              //   onTap: (){
              //     Get.to(ScheduleDateTimeScreen());
              //   },
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 15),
              //     width: Get.width,
              //     height: Get.height * 0.06,
              //     decoration: BoxDecoration(
              //         color: ColorssA.primaryColor,
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(child: Text('Book Now',style: TextStyle(color: Colors.white),),),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
