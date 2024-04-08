import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [
              ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
                          color: Colors.black26.withOpacity(0.15))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Service Name: Heart'),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Text('Booking Date: ${DateTime.now().day} / ${DateTime.now().month}/ ${DateTime.now().year}'),

                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ), Text('Allocated Time Slot : 4PM - 7PM'),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Text('Dr: XYZ'),

                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorssA.primaryColor
                              ),
                              child: Center(child: Text('Edit',style: TextStyle(color: Colors.white),),),
                            ),
                            Container(
                              width: 100,height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorssA.errorColor
                              ),
                              child: Center(child: Text('Delete',style: TextStyle(color: Colors.white),),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
